{ config, pkgs, ... }:
{
  imports = [
    ../../../home/profiles/desktop.nix
    ../../../home/profiles/personal.nix
    ../../../home/profiles/work.nix
    ../../../home/profiles/ctf.nix
    ../../../home/configs/sway.nix
    ../../../home/configs/go.nix
  ];
  home.packages = [
    pkgs.nix-config-shell
  ];
}
