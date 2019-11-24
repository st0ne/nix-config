{ config, lib, pkgs, ... }:

# dynamic tiling window manager i3wm (https://i3wm.org/)
# ref: https://nixos.wiki/wiki/I3

{
  environment.pathsToLink = [ "/libexec" ];

  system.userActivationScripts = {
    # link to i3 config file
    i3Setup = {
      text = '' ln -sfn /data/user/$USER/Config/i3/${config.host.name}/ ~/.config/i3 '';
      deps = [];
    };
    polybarSetup = {
      text = '' ln -sfn /data/user/$USER/Config/polybar/${config.host.name} ~/.config/polybar '';
      deps = [];
    };
  };

  services = {
    xserver.windowManager.i3 = {
      enable = true;
      # xinitrc replacement
      extraSessionCommands = ''
        userresources=$HOME/.Xresources
        usermodmap=$HOME/.Xmodmap
        sysresources=/etc/X11/xinit/Xresources
        sysmodmap=/etc/X11/xinit/Xmodmap
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

      # misc bars
      i3lock
      i3status
      i3blocks
    ];
  };
    # standalone compositor
    # a must have if your use the modesettig driver for xorg
    compton  = {
      enable = lib.mkDefault true;
      backend = lib.mkDefault "glx";
    };
  };
  # control backlight
  programs.light.enable = lib.mkDefault true;
}
