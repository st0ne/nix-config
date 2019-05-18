{ pkgs, ... }:


let
# allow unstable unfree pkgs
unstable = import <nixos-unstable>
{
  config.allowUnfree = true;
};
in
{
  # allow unfree pkgs (stable)
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # general
    lxappearance-gtk3
    zathura

    # terminal
    unstable.alacritty
    #alacritty

    # gnupg
    gpa
    pinentry

    # xorg tools
    xclip
    xorg.xev
    xorg.xmodmap

    # themes
    matcha
    arc-theme

    # browser
    chromium
    firefox
    qutebrowser

    # communication
    signal-desktop
    slack
    unstable.riot-desktop
    thunderbird

    # libnotify
    libnotify
    dunst

    #video
    gstreamer
    gst-python

    # coding
    unstable.vscode

    #misc
    gparted
    pavucontrol
    keepassxc
    networkmanager-openvpn
  ];
}