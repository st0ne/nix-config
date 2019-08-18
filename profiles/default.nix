{ config, lib, pkgs, ... }:

# default definition of any host

{
  # import custom config
  imports = [
    ../config
    ./fstab/lvm.nix
  ];

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

  environment.systemPackages = with pkgs; [
    ## core
    curl rsync screen tree dhcpcd
  ];

  # allow ping
  networking.firewall.allowPing = true;
}