{ lib, pkgs, ... }:

{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  environment.systemPackages = with pkgs; [ yubikey-manager yubikey-manager-qt ];
}

