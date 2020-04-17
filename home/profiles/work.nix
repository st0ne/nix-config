{ pkgs, ... }:

let
  workConfigs = [
    ../configs/go.nix
  ];
  workPkgs = with pkgs; [
    chromium
    flashrom
    zoom-us
  ];
in
{
  imports = workConfigs;
  home.packages = workPkgs;
}
