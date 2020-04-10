{ pkgs, ... }:

let
  workConfigs = [
    ../configs/go.nix
  ];
  workPkgs = with pkgs; [
    zoom-us
    flashrom
  ];
in
{
  imports = workConfigs;
  home.packages = workPkgs;
}
