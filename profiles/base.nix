{ config, lib, pkgs, ... }:

# Base profile, with will be included in any host. It includes essential
# configurations and pkgs.

{
  imports = 
  [
    ../options/general.nix # custom options
    
    ./base/boot.nix
    ./base/fstab.nix
    ./base/env.nix
    ./base/config.nix
    ./base/pkgs.nix
  ];
}
  
