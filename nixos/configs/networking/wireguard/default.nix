{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireguard wireguard-tools
  ];
  networking.wireguard.enable = true;
}
