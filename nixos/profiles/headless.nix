{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.profiles.headless;

in

{
  options = {
    profiles.headless = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      ssh = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = ''
          enable ssh
          '';
        };
        avahi = mkOption {
          type = types.bool;
          default = false;
        };
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
  };

  config = mkIf cfg.enable {
    # enable serial console
    boot = lib.mkIf cfg.serial.enable {
      kernelParams = [
        "console=${cfg.serial.device},${toString cfg.serial.baud}n8"
      ];
      loader.grub.extraConfig = "
        serial --speed=${toString cfg.serial.baud} --unit=0 --word=8 --parity=no --stop=1
        terminal_input serial
        terminal_output serial
      ";
    };
    # enable sshd
    services.openssh = lib.mkIf cfg.ssh.enable {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = lib.mkDefault "prohibit-password";
    };
    systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    services.avahi = lib.mkIf (cfg.ssh.enable && cfg.ssh.avahi) {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
      extraServiceFiles = {
        ssh = "${pkgs.avahi}/etc/avahi/services/ssh.service";
      };
    };
  };
}
