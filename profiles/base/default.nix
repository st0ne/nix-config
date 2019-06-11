{ config, lib, pkgs, ... }:

# Base profile, with will be included in any host. It includes essential
# configurations and pkgs.

{
  imports = 
  [
    ../../config/general.nix # custom options
    
    ./boot.nix
    ./fstab.nix
    ./env.nix
    ./config.nix
    ./pkgs.nix
  ];
}
  
