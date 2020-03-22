{ config , ... }:

{
  boot.supportedFilesystems = ["zfs"];
  fileSystems."/" =
    { device = "${config.custom.hostname}/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/data" =
    { device = "${config.custom.hostname}/data";
      fsType = "zfs";
    };
}
