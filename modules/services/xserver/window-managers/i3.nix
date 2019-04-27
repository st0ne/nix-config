{ config, lib, pkgs, ... }:

# dynamic tiling window manager i3wm (https://i3wm.org/)
# ref: https://nixos.wiki/wiki/I3

{
  environment = {
    pathsToLink = [ "/libexec" ];
    # add i3 config file
    etc."per-user/i3/config".text = import ../../../../configs/i3/config/default.nix {};
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
      i3blocks
      light
      acpi
    ];
  };
  # control backlight
  programs.light.enable = lib.mkDefault true;
}
