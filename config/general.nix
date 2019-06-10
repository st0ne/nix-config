{ config, lib, ... }:

with lib;

{
  options.general = {
    name = mkOption {
      type = types.str;
      default = "default";
      description = ''
      default device partition
      '';
    };
    boot = {
      default = mkOption {
        type = types.bool;
        default = true;
      };
      efi = mkOption {
        type = types.str;
        default= "/dev/sda1";
        description = ''
        main disk
        '';
      };
      encryptData = mkOption {
        type = types.bool;
        default = false;
        description = ''
        encrypted data partition
        '';
      };
      encryptHome = mkOption {
        type = types.bool;
        default = false;
        description = ''
        encrypted home partition
        '';
      };
    };
    dpi = mkOption {
      type = types.int;
      default = null;
      description = ''
        monitor DPI
        '';
    };
  };
}