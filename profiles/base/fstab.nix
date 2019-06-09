{ config, lib, ... }:

let
  cryptData = {
    # cryptdevice with all my persistent data
    name = "data";
    device = "/dev/${config.general.name}/data";
    preLVM = false;
  };
  cryptHome = {
    # encrypted home partition
    name = "home";
    device = "/dev/${config.general.name}/home";
    preLVM = false;
  };
   cryptDevices =
     lib.optional config.general.boot.encryptData cryptData ++
     lib.optional config.general.boot.encryptHome cryptHome;

in {
  boot = {
    initrd = {
      luks.devices = cryptDevices;
    };
  };
  fileSystems = lib.mkIf config.general.boot.default {
    "/" = {
      device = "/dev/${config.general.name}/nixos";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
   };
     "/boot/efi" = lib.mkIf config.boot.loader.grub.efiSupport {
      device = config.general.boot.efi;
      fsType = "vfat";
    };
    # partition with persistent data (user & host)
    "/data" = {
      device = if config.general.boot.encryptData then "/dev/mapper/data" else "/dev/${config.general.name}/data";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
    "/home" = lib.mkIf config.general.boot.encryptHome {
      device = "/dev/mapper/home";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
  };
}