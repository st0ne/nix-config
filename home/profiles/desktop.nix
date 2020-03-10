{ config, pkgs, ... }:

let
  desktopConfigs = [
    ../configs/termite.nix
  ];
  desktopPkgs = with pkgs; [
    dmenu
    firefox
    spotify
    thunderbird
  ];
in
{
  imports = [ ./. ] ++ desktopConfigs;

  home.packages = desktopPkgs;
}
