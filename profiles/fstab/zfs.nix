{ config, lib, pkgs, ... }:

{
  boot.supportedFilesystems = ["zfs"];
  fileSystems."/" =
    { device = "${config.host.name}-zroot/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/data" =
    { device = "${config.host.name}-zroot/data";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "${config.host.name}-zroot/home";
      fsType = "zfs";
    };

  fileSystems."/efi" =
    { device = config.host.boot.device;
      fsType = "vfat";
    };
}
