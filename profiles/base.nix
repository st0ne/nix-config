{ config, lib, pkgs, ... }:

# Base profile, with will be included in any host. It includes essential
# configurations and pkgs.

{
  imports = 
    [
      ../options/general.nix # custom options
    ];

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
  # timezone
  time.timeZone = lib.mkDefault "Europe/Berlin";

  # hostname
  networking.hostName = config.general.name;

  # vim as default editor
  programs.vim.defaultEditor = true;

  ### CONFIGS ##################################################################
  # generate a static config path
  environment.etc = {
    # htop
    "per-user/htop/htoprc".text = import ../configs/htop/default.nix {};

  };
  system.activationScripts = {
    };
  system.userActivationScripts = {
    htopSetup = {
      text = '' ln -sfn /etc/per-user/htop ~/.config/ '';
      deps = [];
    };
  };

  ### PKGS #####################################################################
  environment.systemPackages = with pkgs; [
    ## core
    curl
    rsync
    screen
    tree
    git
    dhcpcd

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
