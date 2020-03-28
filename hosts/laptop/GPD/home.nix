{ config, pkgs, ... }:

{
  imports = [
    ../../../home/profiles/desktop
    ../../../home/configs/sway.nix
  ];
}
