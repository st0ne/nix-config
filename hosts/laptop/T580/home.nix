{ config, pkgs, ... }:

{
  imports = [
    ../../../home/profiles/desktop.nix
    ../../../home/configs/sway.nix
    ../../../home/configs/go.nix
  ];
}
