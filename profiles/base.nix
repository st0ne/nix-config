{ config, lib, pkgs, ... }:

# It includes essential configurations and pkgs.

{
  imports = 
  [
    ./core.nix # parent
    ./base
  ];
}
  
