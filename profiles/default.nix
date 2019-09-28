{ config, lib, pkgs, ... }:

# default definition of any host

with lib;
let
  nixpkgsPath = "/data/nixpkgs";
  nixos-configPath = "/data/nixos-config";
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

  # import custom config
  imports = [
    ./pkgs/core.nix

    # optional TODO: make lvm optional
    ./fstab/lvm.nix

    # modules
    ../modules/programs/tmux.nix
  ];

  config = {
  # use my own Repo as source (no channels)
  #nix.nixPath = [
  #  "nixpkgs=${nixpkgsPath}"
  #  "nixos-config=${nixos-configPath}/configuration.nix"
  #];

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
        canTouchEfiVariables = true;
        # I prefer a separated efi patition
        efiSysMountPoint = "/boot/efi";
      };
      # define grub2 as default bootloader
      grub = {
        enable = lib.mkDefault true;
        version = 2;
        device = if config.host.boot.efi then "nodev" else config.host.boot.device;
        efiSupport = config.host.boot.efi;
      };
    };
  };
  fileSystems = lib.mkIf config.host.boot.default {
    "/boot/efi" = lib.mkIf config.host.boot.efi {
      device = config.host.boot.device;
      fsType = "vfat";
    };
  };

  # console
  i18n = {
    consoleFont = lib.mkDefault "Lat2-Terminus16";
    consoleKeyMap = lib.mkDefault "us";
    defaultLocale = lib.mkDefault "en_US.UTF-8";
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
