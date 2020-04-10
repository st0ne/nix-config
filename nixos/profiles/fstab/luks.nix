{ config , lib, ... }:

with lib;

let

  cfg = config.profiles.fstab.luks;

in

{
  options = {
    profiles.fstab.luks = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      name = mkOption {
        type = types.str;
        default = config.hostname;
      };
      device = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      keyFile = mkOption {
        type = types.str;
        default = "/keyfile.bin";
      };
      initrdKey = mkOption {
        type = types.str;
        default = "/boot/initrd.keys.gz";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.device != null;
        message = "luks requires profiles.fstab.luks.device to be set";
      }
    ];
    boot = {
      initrd.luks.devices."${cfg.name}" = {
        device = cfg.device;
        keyFile = cfg.keyFile;
        allowDiscards = true;
      };
      loader = {
        grub = {
          extraInitrd = cfg.initrdKey;
          enableCryptodisk = true;
          zfsSupport = true;
        };
      };
    };
  };
}
