{ config, lib, ... }:

with lib;

let

  cfg = config.profiles.fstab.zfs;

  # generate hostId based on string
  hostIdGen = str: builtins.substring 0 8 (builtins.hashString "md5" str);

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
    # generate hostId based on hostname.
    networking.hostId = hostIdGen config.networking.hostName;
    boot.supportedFilesystems = [ "zfs" ];
    fileSystems."/" =
      {
        device = "${cfg.zpool}/root/nixos";
        fsType = "zfs";
      };

    fileSystems."/data" =
      {
        device = "${cfg.zpool}/data";
        fsType = "zfs";
      };
  };
}
