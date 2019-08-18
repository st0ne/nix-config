{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl rsync screen tree dhcpcd
  ]; 
}