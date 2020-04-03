{ config, pkgs, ... }:

let
  desktopConfigs = [
  ];
  desktopPkgs = with pkgs; [
    spotify
    thunderbird
    discord
  ];
in
{
  imports = [ ./. ] ++ desktopConfigs;

  home.packages = desktopPkgs;
}
