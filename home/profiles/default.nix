{ config, pkgs, ... }:

let
  baseConfigs = [
    ../configs/bash.nix
    ../configs/git.nix
    ../configs/tmux.nix
    ../configs/neovim.nix
  ];
  basePkgs = with pkgs; [
    dfc
    file
    htop
    mosh
  ];
in
{
  imports = baseConfigs;
  home.packages = basePkgs;
}
