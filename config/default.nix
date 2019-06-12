{ config, lib, ... }:

with lib;

{
  options.host = {
    name = mkOption {
      type = types.str;
      default = "default";
      description = ''
      default device partition
      '';
    };
    dpi = mkOption {
      type = types.int;
      default = null;
      description = ''
        monitor DPI
        '';
    };
    boot = {
      default = mkOption {
        type = types.bool;
        default = true;
        description = ''
        default partition structure
        '';
      };
      efi = mkOption {
        type = types.str;
        default= "/dev/sda1";
        description = ''
        efi partition
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
  };
}