{ config, lib, pkgs, ... }:

# Profile for any personal device with direct user interaction
# (e.g. Workstations, laptops, media devices).

  {
  imports = [
    ./default.nix # parent
    ./pkgs/desktop.nix
    ../modules/networking/network-manager.nix
  ];

  ### HARDWARE #################################################################
  # enable sound
  sound.enable = lib.mkDefault true;
  hardware = {
    pulseaudio = {
      enable = lib.mkDefault true;
      # add the extended pkg to support bluetooth audio
      package = pkgs.pulseaudioFull;
    };
  };
  # enable bluetooth
  hardware.bluetooth.enable = lib.mkDefault true;
  # enable accelerated OpenGL rendering
  hardware.opengl.enable = lib.mkDefault true;

  ### NETWORK ##################################################################
  # use NetworkManager
  networking = {
    networkmanager.enable = lib.mkDefault true;
    dhcpcd.enable = lib.mkDefault false;
  };

  ### FONTS ####################################################################
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
    hack-font
    dejavu_fonts
    fira-code
    font-awesome-ttf
    ];
    fontconfig = {
      enable = lib.mkDefault true;
      defaultFonts = {
        monospace = [ "Hack" ];
        sansSerif = [ "DejaVu Sans" ];
        serif     = [ "DejaVu" ];
      };
    };
  };

  ### SERVICES #################################################################
  services = {
    # minimize log size
    journald.extraConfig = "SystemMaxUse=500M";
    # enable avahi protocol to mdns addresses
    avahi = {
      enable = lib.mkDefault true;
      nssmdns = true;
      #ipv6 = true;
    };
    blueman.enable = lib.mkDefault true;
    # secure firmware updates
    fwupd.enable = lib.mkDefault true;
    # ACPI event handler
    acpid.enable = true;
  };

  programs = {
    # enable gnupg ssh-agent
    gnupg.agent = {
      enable = lib.mkDefault true;
      enableSSHSupport =true;
    };
  };
}
