{ config, options, lib, pkgs, ... }:

with lib;

let

  nix-config = let top = ../..; in "nix-config=${toString top}";

  consoleFont = "Lat2-Terminus16";

  us = "en_US.UTF-8";
  de = "de_DE.UTF-8";

in

{
  imports = [
    ./pkgs
  ] ++ import ./profile-list.nix;

  # custom toplevel options
  options = {
    hostname = mkOption {
      type = types.str;
      default = "nixos";
      description = ''
        name of the host
      '';
    };
    bootloader = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          enable bootloader
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

  config = {

    # append this repository to NIX_PATH
    nix.nixPath = options.nix.nixPath.default ++ [ nix-config ];

    boot = {
      kernelPackages = mkDefault pkgs.linuxPackages;
      cleanTmpDir = mkDefault true;
      tmpOnTmpfs = mkDefault true;
      kernelParams = [
        # old ifnames (e.g. eth0, wlan0)
        "net.ifnames=0"
      ];
      loader = {
        efi = {
          canTouchEfiVariables = mkDefault false;
          # I prefer a separated efi patition
          efiSysMountPoint = "/efi";
        };
        # define grub2 as default bootloader
        grub = {
          enable = config.bootloader.enable;
          version = 2;
          device = if config.bootloader.efi then "nodev" else config.bootloader.device;
          efiSupport = config.bootloader.efi;
          efiInstallAsRemovable = mkDefault ( if (config.bootloader.enable && config.bootloader.efi) then true else false ) ;
        };
      };
    };
    fileSystems."/efi" = mkIf (config.bootloader.enable && config.bootloader.efi) {
      device = config.bootloader.device;
      fsType = "vfat";
    };

    # locale & console
    console = {
      font = mkDefault consoleFont;
      keyMap = mkDefault "us";
    };
    i18n = {
      defaultLocale = mkDefault us;
      extraLocaleSettings = {
        LC_ADDRESS = mkDefault de;
        LC_COLLATE = mkDefault de;
        LC_IDENTIFICATION = mkDefault de;
        LC_MONETARY = mkDefault de;
        LC_MESSAGES = mkDefault us;
        LC_MEASUREMENT = mkDefault de;
        LC_NAME = mkDefault de;
        LC_NUMERIC = mkDefault de;
        LC_PAPER = mkDefault de;
        LC_TELEPHONE = mkDefault de;
        LC_TIME = mkDefault de;
      };
    };

    # timezone
    time.timeZone = mkDefault "Europe/Berlin";

    # hostname
    networking.hostName = config.hostname;

    # vim as default editor
    programs.vim.defaultEditor = mkDefault true;

    # allow ping
    networking.firewall.allowPing = mkDefault  true;
    # disable annoying network logs
    networking.firewall.logRefusedConnections = mkDefault false;

    location = {
      # hard code geolocation for redshift
      # welcome to Bochum :)
      latitude = mkDefault 51.48;
      longitude = mkDefault 7.22;
    };
  };
}
