{ config, lib, pkgs, ... }:

# dynamic tiling window manager i3wm (https://i3wm.org/)
# ref: https://nixos.wiki/wiki/I3

{
  environment = {
    pathsToLink = [ "/libexec" ];
    # add i3 config file
    etc."per-user/i3/config".text = import ../../../../configs/i3/config/default.nix {};
    # i3status
    etc."per-user/i3/i3status".text = import ../../../../configs/i3/i3status/default.nix {};
  };

  system.userActivationScripts = {
    # link to i3 config file
    i3Setup = {
      text = '' ln -sfn /etc/per-user/i3 ~/.config '';
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
