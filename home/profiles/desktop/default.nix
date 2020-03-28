{ config, pkgs, ... }:

let
  desktopConfigs = [
    ../../configs/termite.nix
  ];
  desktopPkgs = with pkgs; [
    firefox
  ];
in
{
  imports = [ ../. ] ++ desktopConfigs;

  home.packages = desktopPkgs;
}
