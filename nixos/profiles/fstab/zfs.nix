{ config , lib, ... }:

with lib;

let

  cfg = config.profiles.fstab.zfs;

in

{
  options = {
    profiles.fstab.zfs = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      zpool = mkOption {
        type = types.str;
        default = config.hostname;
      };
    };
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = ["zfs"];
    fileSystems."/" =
      { device = "${cfg.zpool}/root/nixos";
        fsType = "zfs";
      };

    fileSystems."/data" =
      { device = "${cfg.zpool}/data";
        fsType = "zfs";
      };
  };
}
