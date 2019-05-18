{ pkgs, ... }:

{
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