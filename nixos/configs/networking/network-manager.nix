{ config, lib, ... }:

{
  networking = {
    networkmanager.enable = lib.mkDefault true;
    dhcpcd.enable = lib.mkDefault false;
  };
  system.activationScripts = {
    networkmanagerSetup = {
      text = ''
        mkdir -p /data/host/networkmanager/system-connections/
        mkdir -p /data/host/networkmanager/cert/
        ln -sfn /data/host/networkmanager/system-connections/ /etc/NetworkManager/system-connections
        ln -sfn /data/host/networkmanager/cert/ /etc/NetworkManager/cert
      '';
      deps = [];
    };
  };
}
