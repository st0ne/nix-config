# Profile for any personal device with direct user interaction
# (e.g. Workstations, laptops, media devices).
{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.profiles.desktop;

  fonts = with pkgs; [
    hack-font
    dejavu_fonts
    fira-code
    font-awesome-ttf
  ];

  defaultFonts = {
    monospace = [ "Hack" ];
    sansSerif = [ "DejaVu Sans" ];
    serif     = [ "DejaVu" ];
  };

  logSize = "500M";

in

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  options = {
    profiles.desktop = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {

    ### HARDWARE ###############################################################
    # enable sound
    sound.enable = mkDefault true;
    hardware = {
      pulseaudio = {
        enable = mkDefault true;
        # add the extended pkg to support bluetooth audio
        package = pkgs.pulseaudioFull;
      };
    };
    # enable bluetooth
    hardware.bluetooth.enable = mkDefault true;
    # enable accelerated OpenGL rendering
    hardware.opengl.enable = mkDefault true;

    ### FONTS ##################################################################
    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      enableDefaultFonts = true;
      inherit fonts;
      fontconfig = {
        enable = mkDefault true;
        inherit defaultFonts;
      };
    };

    ### SERVICES ###############################################################
    services = {
      # minimize log size
      journald.extraConfig = "SystemMaxUse=${logSize}";
      # enable avahi protocol to mdns addresses
      avahi = {
        enable = mkDefault true;
        nssmdns = mkDefault true;
        ipv6 = mkDefault true;
      };
      blueman.enable = mkDefault true;
      # secure firmware updates
      fwupd.enable = mkDefault true;
      # ACPI event handler
      acpid.enable = true;
    };

    programs = {
      # enable gnupg ssh-agent
      gnupg.agent = {
        enable = mkDefault true;
        enableSSHSupport = true;
      };
    };

    ### NETWORKING #############################################################
    networking = {
      networkmanager.enable = lib.mkDefault true;
      dhcpcd.enable = lib.mkDefault false;
    };
  };
}
