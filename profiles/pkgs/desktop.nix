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
    termite
    # gnupg
    gnupg gpa pinentry
    # xorg tools
    xclip xorg.xev xorg.xmodmap arandr
    # browser
    chromium google-chrome firefox qutebrowser
    # communication
    signal-desktop slack riot-desktop gnome3.evolution aspellDicts.de aspellDicts.en
    # libnotify
    libnotify dunst
    #video
    mpv ffmpeg gstreamer gst-python
    #NetworkManager
    networkmanager-openvpn
    #password manager
    keepassxc pass
    #misc
    gparted pavucontrol
  ];
}
