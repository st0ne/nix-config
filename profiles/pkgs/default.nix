{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl rsync dhcpcd
  ];
}
