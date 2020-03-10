{ config , ... }:

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
}
