{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # administation
    nixops
    # organisation
    taskwarrior translate-shell
    ## cli tools
    pwgen jq yq
    ## coding
    gcc gnumake cmake guile-ncurses # general
    go # Go
    cargo rustc # Rust
    gnum4 bison flex zlib # coreboot
    qemu
    kicad-unstable
    nextcloud-client
    speedtest-cli
  ];
}