{ config, pkgs, ... }:
let
  modkey = "Mod4";
  ### workspace icons
  w1 = "1 ";
  w2 = "2 ";
  w3 = "3 ";
  w4 = "4 ";
  w5 = "5 ";
  w6 = "6 ";
  w7 = "7 ";
  w8 = "8 ";
  w9 = "9 ";
  w10 = "10 ";

  ### pkgs
  terminal = "${pkgs.termite}/bin/termite";
  dmenu = "${pkgs.i3}/bin/i3-dmenu-desktop";
  qutebrowser = "${pkgs.qutebrowser}/bin/qutebrowser";
  keepass = "${pkgs.keepassxc}/bin/keepassxc";
  signal = "${pkgs.signal-desktop}/bin/signal-desktop";
  slack = "${pkgs.slack}/bin/slack";
  chromium = "${pkgs.chromium}/bin/chromium";
  firefox = "${pkgs.firefox}/bin/firefox";
  light = "${pkgs.light}/bin/light";
  amixer = "${pkgs.alsaUtils}/bin/amixer";
  ### statusBar
  main-i3statusConf = pkgs.writeText "main-i3status.conf" ''
    general {
        output_format = "i3bar"
        colors = true
        interval = 1
    }
    order += "disk /"
    order += "ethernet eth0"
    order += "wireless wlan0"
    order += "battery 0"
    order += "battery 1"
    order += "tztime local"

    disk "/" {
        format = " %free"
    }

    ethernet eth0 {
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
    }

    wireless wlan0 {
    format_up = "W: [%quality at %essid, %bitrate / %frequency] %ip"
    format_down = "W: down"
    }

    battery 0 {
        format = "%status %percentage %remaining"
        format_down = "No battery"
        status_chr = ""
        status_bat = " "
        status_unk = " "
        status_full = " "
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 5
    }

    battery 1 {
        format = "%status %percentage %remaining"
        format_down = "No battery"
        status_chr = ""
        status_bat = " "
        status_unk = " "
        status_full = " "
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
    }

    tztime local {
       format = "%d.%m.%y %H:%M:%S"
    }
    '';
in
{
  home-manager.users.sylv.xdg.configFile."i3/main-i3status.conf" = {
    source = main-i3statusConf;
  };
  home-manager.users.sylv.xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = modkey;
      window = {
        titlebar = false;
        border = 2;
        hideEdgeBorders = "smart";
      };
      assigns = {
        "${w3}" = [{ class = "^qutebrowser$"; }];
        "${w5}" = [{ class = "^keepassxc$"; }];
        "${w6}" = [{ class = "^Signal$"; }];
        "${w7}" = [{ class = "^Slack$"; }];
        "${w8}" = [{ class = "^Evolution$"; }];
        "${w9}" = [{ class = "^Chromium-browser$"; }];
        "${w10}" = [{ class = "^Firefox$"; }];
      };
      bars = [
        {
          id = "main";
          position = "bottom";
          fonts = [ "Hack 10" ];
          statusCommand = "${pkgs.i3status}/bin/i3status -c ~/.config/i3/main-i3status.conf";
        }
      ];
      focus = {
        followMouse = false;
      };
      keybindings = {
        "${modkey}+h" = "focus left";
        "${modkey}+j" = "focus down";
        "${modkey}+k" = "focus up";
        "${modkey}+l" = "focus right";

        "${modkey}+Shift+h" = "move left";
        "${modkey}+Shift+j" = "move down";
        "${modkey}+Shift+k" = "move up";
        "${modkey}+Shift+l" = "move right";
        "${modkey}+Shift+Left" = "move workspace to output left";
        "${modkey}+Shift+Down" = "move workspace to output down";
        "${modkey}+Shift+Up" = "move workspace to output up";
        "${modkey}+Shift+Right" = "move workspace to output right";

        "${modkey}+b" = "split h";
        "${modkey}+v" = "split v";
        "${modkey}+f" = "fullscreen toggle";

        "${modkey}+s" = "layout stacking";
        "${modkey}+w" = "layout tabbed";
        "${modkey}+e" = "layout toggle split";

        "${modkey}+Shift+space" = "floating toggle";
        "${modkey}+space" = "focus mode_toggle";

        "${modkey}+1" = "workspace ${w1}";
        "${modkey}+2" = "workspace ${w2}";
        "${modkey}+3" = "workspace ${w3}";
        "${modkey}+4" = "workspace ${w4}";
        "${modkey}+5" = "workspace ${w5}";
        "${modkey}+6" = "workspace ${w6}";
        "${modkey}+7" = "workspace ${w7}";
        "${modkey}+8" = "workspace ${w8}";
        "${modkey}+9" = "workspace ${w9}";
        "${modkey}+0" = "workspace ${w10}";

        "${modkey}+shift+1" = "move container to workspace ${w1}";
        "${modkey}+shift+2" = "move container to workspace ${w2}";
        "${modkey}+shift+3" = "move container to workspace ${w3}";
        "${modkey}+shift+4" = "move container to workspace ${w4}";
        "${modkey}+shift+5" = "move container to workspace ${w5}";
        "${modkey}+shift+6" = "move container to workspace ${w6}";
        "${modkey}+shift+7" = "move container to workspace ${w7}";
        "${modkey}+shift+8" = "move container to workspace ${w8}";
        "${modkey}+shift+9" = "move container to workspace ${w9}";
        "${modkey}+shift+0" = "move container to workspace ${w10}";

        "${modkey}+shift+q" = "kill";
        "${modkey}+shift+r" = "restart";
        "${modkey}+shift+Escape" =  "exit";

        # Programs
        "${modkey}+Return" = "exec ${terminal}";
        "${modkey}+d" = "exec ${dmenu}";
        "${modkey}+shift+p" = "exec ${keepass}";
        "${modkey}+shift+m" = "exec ${signal}";
        "${modkey}+shift+s" = "exec ${slack}";
        "${modkey}+shift+b" = " exec ${qutebrowser}";
        "${modkey}+shift+c" = " exec ${chromium}";
        "${modkey}+shift+f" = " exec ${firefox}";

        # Backlight
        "XF86MonBrightnessUp" = "exec --no-startup-id ${light} -A 10";
        "Shift+XF86MonBrightnessUp" = "exec --no-startup-id ${light} -A 1";
        "XF86MonBrightnessDown" = "exec --no-startup-id ${light} -U 10";
        "Shift+XF86MonBrightnessDown" = "exec --no-startup-id ${light} -U 1";

        # Audio
        "XF86AudioMute" = "exec --no-startup-id ${amixer} -q set Master toggle";
        "XF86AudioMicMute" = "exec --no-startup-id ${amixer} -q set Capture toggle";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${amixer} set Master -q 5%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${amixer} set Master -q 5%-";
      };
    };
  };
}
