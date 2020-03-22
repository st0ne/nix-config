{ config, lib, pkgs, ... }:

# default definition of any host

with lib;
let
  us = "en_US.UTF-8";
  de = "de_DE.UTF-8";
in
  {
    # custom option declaration
    options.custom = {
      hostname = mkOption {
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
      boot = {
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
      };
    };

  # import custom config
  imports = [
    ./pkgs
  ];

  config = {
    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      cleanTmpDir = lib.mkDefault true;
      tmpOnTmpfs = lib.mkDefault true;
      kernelParams = [
        # old ifnames (e.g. eth0, wlan0)
        "net.ifnames=0"
      ];
      loader = {
        efi = {
          canTouchEfiVariables = lib.mkDefault false;
          # I prefer a separated efi patition
          efiSysMountPoint = "/efi";
        };
        # define grub2 as default bootloader
        grub = {
          enable = lib.mkDefault true;
          version = 2;
          device = if config.custom.boot.efi then "nodev" else config.custom.boot.device;
          efiSupport = config.custom.boot.efi;
          efiInstallAsRemovable = lib.mkDefault true;
        };
      };
    };
    fileSystems."/efi" = lib.mkIf config.custom.boot.efi {
      device = config.custom.boot.device;
      fsType = "vfat";
    };

    # locale & console
    i18n = {
      consoleFont = lib.mkDefault "Lat2-Terminus16";
      consoleKeyMap = lib.mkDefault "us";
      defaultLocale = lib.mkDefault us;
      extraLocaleSettings = {
        LC_ADDRESS = lib.mkDefault de;
        LC_COLLATE = lib.mkDefault de;
        LC_IDENTIFICATION = lib.mkDefault de;
        LC_MONETARY = lib.mkDefault de;
        LC_MESSAGES = lib.mkDefault us;
        LC_MEASUREMENT = lib.mkDefault de;
        LC_NAME = lib.mkDefault de;
        LC_NUMERIC = lib.mkDefault de;
        LC_PAPER = lib.mkDefault de;
        LC_TELEPHONE = lib.mkDefault de;
        LC_TIME = lib.mkDefault de;
      };
    };

    # timezone
    time.timeZone = lib.mkDefault "Europe/Berlin";

    # hostname
    networking.hostName = config.custom.hostname;
    networking.domain = config.custom.domain;

    # vim as default editor
    programs.vim.defaultEditor = true;

    # allow ping
    networking.firewall.allowPing = true;
    # disable annoying network logs
    networking.firewall.logRefusedConnections = false;

    location = {
      # hard code geolocation for redshift
      # welcome to Bochum :)
      latitude = lib.mkDefault 51.48;
      longitude = lib.mkDefault 7.22;
    };
  };
}
