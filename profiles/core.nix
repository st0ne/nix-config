{ config, lib, pkgs, ... }:

# core definition of any host

let
  cryptData = {
    # cryptdevice with all my persistent data
    name = "data";
    device = "/dev/${config.host.name}/data";
    preLVM = false;
  };
  cryptHome = {
    # encrypted home partition
    name = "home";
    device = "/dev/${config.host.name}/home";
    preLVM = false;
  };
   cryptDevices =
     lib.optional config.host.boot.encryptData cryptData ++
     lib.optional config.host.boot.encryptHome cryptHome;

in {
  # import custom config
  imports = [ ../config ];

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
    initrd = {
      luks.devices = cryptDevices;
    };
  };
  # setup default partition layout if enabled
  fileSystems = lib.mkIf config.host.boot.default {
    "/" = {
      device = "/dev/${config.host.name}/nixos";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
     "/boot/efi" = lib.mkIf config.host.boot.efi {
      device = config.host.boot.device;
      fsType = "vfat";
    };
    # partition with persistent data (user & host)
    "/data" = {
      device = if config.host.boot.encryptData then "/dev/mapper/data" else "/dev/${config.host.name}/data";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
    "/home" = lib.mkIf config.host.boot.encryptHome {
      device = "/dev/mapper/home";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
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
}