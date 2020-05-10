{ lib, pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubikey-manager
    yubikey-manager-qt
  ];
}
