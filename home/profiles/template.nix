{ pkgs, ... }:

let
  templateConfigs = [
  ];
  templatePkgs = with pkgs; [
  ];
in
{
  imports = templateConfigs;
  home.packages = templatePkgs;
}
