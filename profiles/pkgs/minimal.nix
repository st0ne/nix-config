{ config, lib, pkgs, ... }:

# It includes essential pkgs.

{
  imports = [ ./. ];

  ### PKGS #####################################################################
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    ## Version control
    git
    # files
    file lsof ranger
    # binary
    ltrace strace python37Packages.binwalk-full linuxPackages.perf smartmontools pmutils
    psmisc which file binutils bc utillinuxCurses exfat dosfstools patchutils moreutils
    ## monitoring
    htop iotop iftop powertop
    # hardware
    lshw usbutils pciutils dmidecode lm_sensors smartmontools
    ## lookup
    whois dnsutils
    ## communication
    telnet
    ## network tools
    tcpdump nettools mtr siege tcptraceroute inetutils wireshark nix-prefetch-scripts iptables
    ## compression
    zip unzip unrar p7zip xz lz4
    # Man pages
    man man-pages posix_man_pages stdman
  ];
}

