{ lib, pkgs, ... }:

# Base profile, with will be included in any host. It includes essential
# configurations and pkgs.

{
  ### BOOT #####################################################################
  boot = {
    cleanTmpDir = lib.mkDefault true;
    tmpOnTmpfs = lib.mkDefault true;
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
        device = "nodev";
        efiSupport = true;
      };
    };
    kernelParams = [
      # old ifnames (e.g. eth0, wlan0)
      "net.ifnames=0"
    ];
  };

  ### LOCALE ###################################################################
  i18n = {
    consoleFont = lib.mkDefault "Lat2-Terminus16";
    consoleKeyMap = lib.mkDefault "us";
    defaultLocale = lib.mkDefault "en_US.UTF-8";
  };
  time.timeZone = lib.mkDefault "Europe/Berlin";

  ### PKGS #####################################################################
  environment.systemPackages = with pkgs; [
    ## core
    curl
    rsync
    screen
    tree
    git

    ## analysis
    # files
    file
    lsof
    # disk
    dfc
    # binary
    strace
    python37Packages.binwalk-full
    # hardware
    lshw
    usbutils
    pciutils
    dmidecode
    lm_sensors

    ## monitoring
    htop
    iotop
    iftop
    tcpdump

    ## lookup
    whois

    ## communication
    telnet
    gnupg

    ## network tools
    nettools
    mtr
    siege
    tcptraceroute

    ## compression
    xz
    lz4
    zip
    unzip

    ## editor
    vim

    ## cli tools
    pwgen
    jq
    yq

    ## coding
    go
    gcc
    gnumake
    cmake
    guile-ncurses

  ];
}
