{ config, pkgs, ... }:

{
  imports = [
    ./.
    ./home-manager/i3.nix
    ./home-manager/firefox.nix
    ./home-manager/termite.nix
    ./home-manager/dunst.nix
  ];
}
