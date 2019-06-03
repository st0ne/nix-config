{ config, lib, pkgs, ... }:

# dynamic tiling window manager i3wm (https://i3wm.org/)
# ref: https://nixos.wiki/wiki/I3

{
  environment.pathsToLink = [ "/libexec" ];

  system.userActivationScripts = {
    # link to i3 config file
    i3Setup = {
      text = '' ln -sfn /data/user/$USER/Config/i3/${config.general.name}/ ~/.config/i3 '';
      deps = [];
    };
  };

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3lock
      i3status
      i3blocks
      light
      acpi

      polybar
      cairo
      xorg.libxcb
      xorg.xcbproto
      xorg.xcbutilimage
      xorg.xcbutilwm
      xorg.xcbutilcursor
      xcbutilxrm
      alsaLib
      libpulseaudio
      mpd_clientlib
    ];
  };
  # control backlight
  programs.light.enable = lib.mkDefault true;
}
