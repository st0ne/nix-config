{ config, lib, ... }:

with lib;

{
  options.host = {
    ssh = mkOption {
      type = types.bool;
      default = false;
      description = ''
      enable ssh
      '';
    };
    serial = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
        enable serial console
        '';
      };
      device = mkOption {
        type = types.string;
        default = "ttyS0";
        description = ''
        serial device
        '';
      };
      baud = mkOption {
        type = types.int;
        default = 115200;
        description = ''
        serial console baudrate
        '';
      };
    };
  };
}