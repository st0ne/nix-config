{ config, pkgs, ... }:

{
  imports = [
    ../../../home/profiles/desktop/full.nix
    ../../../home/profiles/personal.nix
    ../../../home/profiles/ctf.nix
    ../../../home/configs/sway.nix
    ../../../home/configs/go.nix
  ];
}
