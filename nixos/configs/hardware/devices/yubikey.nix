{ lib, pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
  ];
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubikey-manager
    yubikey-manager-qt
  ];
}

