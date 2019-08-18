{ config, lib, ... }:

# Profile for headless server.

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
  
  config = {
  # enable serial console
  boot = lib.mkIf config.host.serial.enable {
    kernelParams = [
      "console=${config.host.serial.device},${toString config.host.serial.baud}n8"
    ];
    loader.grub.extraConfig = "
      serial --speed=${toString config.host.serial.baud} --unit=0 --word=8 --parity=no --stop=1
      terminal_input serial
      terminal_output serial
    ";
  };

  # enable sshd
  services.openssh = lib.mkIf config.host.ssh {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
    challengeResponseAuthentication = false;
  };
  };
}