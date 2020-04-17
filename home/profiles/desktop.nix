{ config, pkgs, ... }:

let
  desktopConfigs = [
    ../configs/termite.nix
  ];
  desktopPkgs = with pkgs; [
    discord
    firefox
    qutebrowser
    signal-desktop
    slack
    spotify
    thunderbird
    zathura
  ];
in
{
  imports = [ ./. ] ++ desktopConfigs;

  home.packages = desktopPkgs;
}
