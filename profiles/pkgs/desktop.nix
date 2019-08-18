{ pkgs, ... }:

{
  imports =
  [
    ./minimal.nix # parent
  ];
  environment.systemPackages = with pkgs; [
    # document/Image viewer
    zathura feh
    # terminal emulator
    alacritty
    # gnupg
    gnupg gpa pinentry
    # xorg tools
    xclip xorg.xev xorg.xmodmap arandr
    # browser
    chromium google-chrome firefox qutebrowser
    # communication
    signal-desktop slack riot-desktop thunderbird gnome3.evolution
    # libnotify
    libnotify dunst
    #video
    mpv ffmpeg gstreamer gst-python
    # coding
    vscode
    #NetworkManager
    networkmanager-openvpn
    #password manager
    keepassxc pass
    #misc
    gparted pavucontrol
  ];
}