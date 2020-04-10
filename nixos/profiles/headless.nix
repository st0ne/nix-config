{ config, lib, ... }:

# Profile for headless server.

with lib;

{
  options.headless = {
    ssh = mkOption {
      type = types.bool;
      default = true;
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
  imports = [ ./default.nix ];
  config = {
    # enable serial console
    boot = lib.mkIf config.headless.serial.enable {
      kernelParams = [
        "console=${config.headless.serial.device},${toString config.headless.serial.baud}n8"
      ];
      loader.grub.extraConfig = "
        serial --speed=${toString config.headless.serial.baud} --unit=0 --word=8 --parity=no --stop=1
        terminal_input serial
        terminal_output serial
      ";
    };

    # enable sshd
    services.openssh = lib.mkIf config.headless.ssh {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = lib.mkDefault "prohibit-password";
      challengeResponseAuthentication = false;
    };
  };
}
