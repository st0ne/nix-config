{ config, lib, pkgs, ... }:

# LVM filesystem

let
  cryptData = {
    # cryptdevice with all my persistent data
    name = "data";
    device = "/dev/${config.host.name}/data";
    preLVM = false;
  };
  cryptHome = {
    # encrypted home partition
    name = "home";
    device = "/dev/${config.host.name}/home";
    preLVM = false;
  };
   cryptDevices =
     lib.optional config.host.boot.encryptData cryptData ++
     lib.optional config.host.boot.encryptHome cryptHome;

in {

  # add cryptdevices
  boot.initrd.luks.devices = cryptDevices;

  # setup default partition layout if enabled
  fileSystems = lib.mkIf config.host.boot.default {
    "/" = {
      device = "/dev/${config.host.name}/nixos";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
    # partition with persistent data (user & host)
    "/data" = {
      device = if config.host.boot.encryptData then "/dev/mapper/data" else "/dev/${config.host.name}/data";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
    "/home" = lib.mkIf config.host.boot.encryptHome {
      device = "/dev/mapper/home";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
  };
}