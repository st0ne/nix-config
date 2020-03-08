{ config, lib, pkgs, ... }:

{
  boot.supportedFilesystems = ["zfs"];
  fileSystems."/" =
    { device = "${config.host.name}/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/data" =
    { device = "${config.host.name}/data";
      fsType = "zfs";
    };

  fileSystems."/efi" =
    { device = config.host.boot.device;
      fsType = "vfat";
    };
}
