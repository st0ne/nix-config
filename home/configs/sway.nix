{ config, pkgs, ... }:

let

  start-sway = pkgs.writeShellScriptBin "start-sway" ''
    # first import environment variables from the login manager
    systemctl --user import-environment
    # then start the service
    exec systemctl --user start sway.service
  '';

  waybarCustom = (pkgs.waybar.override { pulseSupport = true; });

  start-waybar = pkgs.writeShellScriptBin "start-waybar" ''
    export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -f 'sway$').sock
    ${waybarCustom}/bin/waybar
  '';

  autostartProfile = ''
    if [[ -z $DISPLAY ]] && [[ $(${pkgs.coreutils}/bin/tty) = /dev/tty1 ]]; then
      ${start-sway}/bin/start-sway
    fi
  '';

in
{

  home.packages = with pkgs; [
    sway
    start-sway
    swaylock # lockscreen
    swayidle
    xwayland # for legacy apps
    waybarCustom # status bar
    mako # notification daemon
    kanshi # autorandr
    playerctl
    bemenu
    #grim wl-clipboard imv slurp
  ];

  programs.bash.profileExtra = autostartProfile;
  programs.zsh.profileExtra = autostartProfile;

  systemd.user.sockets.dbus = {
    Unit = {
      Description = "D-Bus User Message Bus Socket";
    };
    Socket = {
      ListenStream = "%t/bus";
      ExecStartPost = "${pkgs.systemd}/bin/systemctl --user set-environment DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus";
    };
    Install = {
      WantedBy = [ "sockets.target" ];
      Also = [ "dbus.service" ];
    };
  };

  systemd.user.services.dbus = {
    Unit = {
      Description = "D-Bus User Message Bus";
      Requires = [ "dbus.socket" ];
    };
    Service = {
      ExecStart = "${pkgs.dbus}/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation";
      ExecReload = "${pkgs.dbus}/bin/dbus-send --print-reply --session --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig";
    };
    Install = {
      Also = [ "dbus.socket" ];
    };
  };

  systemd.user.services.sway = {
    Unit = {
      Description = "Sway - Wayland window manager";
      Documentation = [ "man:sway(5)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.sway}/bin/sway";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  systemd.user.services.waybar = {
    Unit = {
      Description = "Wayland bar for Sway and Wlroots based compositors";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${start-waybar}/bin/start-waybar";
      RestartSec = 1;
      Restart = "always";
    };
  };

  systemd.user.services.swayidle = {
    Unit = {
      Description = "Idle manager for Wayland";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = ''${pkgs.swayidle}/bin/swayidle -w \
        timeout 300 'swaylock -f -c 990000' \
        timeout 600 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
        before-sleep 'swaylock -f -c 990000'
        '';
      RestartSec = 3;
      Restart = "always";
    };
  };

  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = ''${pkgs.mako}/bin/mako \
        --default-timeout 10000
        '';
      RestartSec = 3;
      Restart = "always";
    };
  };

  systemd.user.services.kanshi = {
    Unit = {
      Description = "Kanshi dynamic display configuration";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      RestartSec = 3;
      Restart = "always";
    };
  };

  #xdg.configFile."kanshi/config".text = ''
  #  {
  #    output eDP-1 mode 1920x1080 position 0,0
  #    output "ViewSonic Corporation VP2770 SERIES T56131300326" mode 2560x1440 position 1920,0
  #  }
  #  {
  #    output eDP-1 mode 1920x1080 position 0,0
  #  }
  #'';

}
