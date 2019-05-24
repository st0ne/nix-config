{ config, lib, pkgs, ... }:

# Profile for any personal device with direct user interaction
# (e.g. Workstations, laptops, media devices).

  {
  imports = [
    # parent
    ./base.nix

    ./desktop/config.nix
    ./desktop/pkgs.nix
    ./desktop/x11.nix
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
  networking.networkmanager.enable = lib.mkDefault true;

  ### SERVICES #################################################################
  services = {
    # minimize log size
    journald.extraConfig = "SystemMaxUse=500M";
    # enable avahi protocol to mdns addresses
    avahi = {
      enable = lib.mkDefault true;
      nssmdns = true;
    };
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
