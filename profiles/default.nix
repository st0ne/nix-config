{ config, lib, pkgs, ... }:

# default definition of any host

with lib;
let
  nixpkgsPath = "/data/nixpkgs";
  nixos-configPath = "/data/nixos-config";
  us = "en_US.UTF-8";
  de = "de_DE.UTF-8";
in
  {
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
      };
    };

  # import custom config
  imports = [
    ../users
    ./pkgs/core.nix
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
    loader = lib.mkIf config.host.boot.default {
      efi = {
        canTouchEfiVariables = lib.mkDefault false;
        # I prefer a separated efi patition
        efiSysMountPoint = "/efi";
      };
      # define grub2 as default bootloader
      grub = {
        enable = lib.mkDefault true;
        version = 2;
        device = if config.host.boot.efi then "nodev" else config.host.boot.device;
        efiSupport = config.host.boot.efi;
        efiInstallAsRemovable = lib.mkDefault true;
      };
    };
  };
  fileSystems = lib.mkIf config.host.boot.default {
    "/efi" = lib.mkIf config.host.boot.efi {
      device = config.host.boot.device;
      fsType = "vfat";
    };
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
  networking.hostName = config.host.name;
  networking.domain = config.host.domain;

  # vim as default editor
  programs.vim.defaultEditor = true;

  # allow ping
  networking.firewall.allowPing = true;

  location = {
    # hard code geolocation for redshift
    # welcome to Bochum :)
    latitude = lib.mkDefault 51.48;
    longitude = lib.mkDefault 7.22;
  };
};
}
