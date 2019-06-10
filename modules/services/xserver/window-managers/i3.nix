{ config, lib, pkgs, ... }:

# dynamic tiling window manager i3wm (https://i3wm.org/)
# ref: https://nixos.wiki/wiki/I3

{
  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = [ (pkgs.polybar.override { i3Support = true; }) ];

  system.userActivationScripts = {
    # link to i3 config file
    i3Setup = {
      text = '' ln -sfn /data/user/$USER/Config/i3/${config.general.name}/ ~/.config/i3 '';
      deps = [];
    };
    polybarSetup = {
      text = '' ln -sfn /data/user/$USER/Config/polybar/${config.general.name} ~/.config/polybar '';
      deps = [];
    };
  };

  services.xserver.windowManager.i3 = {
    enable = true;
    # xinitrc replacement
    extraSessionCommands = ''
    userresources=$HOME/.Xresources
    usermodmap=$HOME/.Xmodmap
    sysresources=/etc/X11/xinit/Xresources
    sysmodmap=/etc/X11/xinit/Xmodmap
    echo $userresources >> /tmp/reeeeeeeee
    if [ -f $sysresources ]; then
      xrdb -merge $sysresources
    fi
    if [ -f $sysmodmap ]; then
      xmodmap $sysmodmap
    fi
    if [ -f "$userresources" ]; then
      xrdb -merge "$userresources"
    fi
    if [ -f "$usermodmap" ]; then
      xmodmap "$usermodmap"
    fi
    '';
    extraPackages = with pkgs; [
      # app launcher
      dmenu
      j4-dmenu-desktop

      light
      acpi

      alsaLib
      libpulseaudio
      mpd_clientlib

      # polybar
      polybar
      cairo
      siji

      # misc bars
      i3lock
      i3status
      i3blocks
    ];
  };
  # control backlight
  programs.light.enable = lib.mkDefault true;
}
