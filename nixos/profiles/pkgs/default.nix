{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl dhcpcd file htop rsync
  ];
}
