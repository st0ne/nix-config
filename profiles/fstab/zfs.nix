{ config, lib, pkgs, ... }:

{
  boot.supportedFilesystems = ["zfs"];
  fileSystems."/" =
    { device = "${config.host.name}-rpool/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/data" =
    { device = "${config.host.name}-rpool/data";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "${config.host.name}-rpool/home";
      fsType = "zfs";
    };

  fileSystems."/efi" =
    { device = config.host.boot.device;
      fsType = "vfat";
    };
}
