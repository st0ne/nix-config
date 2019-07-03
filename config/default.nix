{ config, lib, ... }:

with lib;

{
  imports = [
    ./headless.nix
  ];

  options.host = {
    name = mkOption {
      type = types.str;
      default = "defaulthost";
      description = ''
      name of the host
      '';
    };
    domain = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
      domain name
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
        type = types.bool;
        default = false;
        description = ''
        enable efi boot
        '';
      };
      device = mkOption {
        type = types.str;
        default= null;
        description = ''
        legacy: grub device
        efi: efi partition
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