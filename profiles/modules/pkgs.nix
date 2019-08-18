{ pkgs, ... }:

{
  imports = [ ./unstable.nix ];

  environment.systemPackages = with pkgs; [
    # document/Image viewer
    zathura feh
    # terminal emulator
    unstable.alacritty
    # gnupg
    gnupg gpa pinentry
    # xorg tools
    xclip xorg.xev xorg.xmodmap arandr
    # browser
    chromium google-chrome firefox qutebrowser
    # communication
    signal-desktop slack unstable.riot-desktop thunderbird gnome3.evolution
    # libnotify
    libnotify dunst
    #video
    mpv ffmpeg gstreamer gst-python
    # coding
    unstable.vscode
    #NetworkManager
    networkmanager-openvpn
    #password manager
    keepassxc pass
    #misc
    gparted pavucontrol
  ];
}