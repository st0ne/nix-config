{ lib, pkgs, ... }:

{
  imports = [
    ../../modules/xserver/libinput.nix
  ];
  services = {
    xserver = {
      # enable xserver by default
      enable = lib.mkDefault true;
      useGlamor = lib.mkDefault true;
      autoRepeatDelay = lib.mkDefault 300;
      autoRepeatInterval = lib.mkDefault 25;
      displayManager = {
        lightdm.greeters.gtk = {
          enable = lib.mkDefault true;
        };
      };
      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
    };
  };
}
