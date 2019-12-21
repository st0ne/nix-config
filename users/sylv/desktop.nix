{ config, pkgs, ... }:

{
  imports = [
    ./.
    ./home-manager/i3.nix
    ./home-manager/termite.nix
  ];
}
