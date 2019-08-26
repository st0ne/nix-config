{ lib, pkgs, ... }:

{
  imports = [
    ../../modules/services/xserver/hardware/libinput.nix
  ];
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
    dejavu_fonts
    fira-code
    font-awesome-ttf
    ];
    fontconfig = {
      enable = lib.mkDefault true;
      defaultFonts.monospace = [ "DejaVu Sans Mono" ];
    };
  };
  services = {
    xserver = {
      # enable xserver by default
      enable = lib.mkDefault true;
      useGlamor = lib.mkDefault true;
      displayManager = {
        lightdm.greeters.gtk = {
          enable = lib.mkDefault true;
        };
      };
      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
    };
    logind = {
    # Required for our screen-lock-on-suspend functionality
      extraConfig = ''
        LidSwitchIgnoreInhibited=False
        HandleLidSwitch=suspend
        HoldoffTimeoutSec=10
      '';
    };
    # adjusts the color temperature of your screen at night
    redshift = {
      enable = lib.mkDefault true;
    };
    compton  = {
      enable = lib.mkDefault true;
      backend = lib.mkDefault "glx";
    };
  };
  location = {
    # hard code geolocation for redshift
    # welcome to Bochum :)
    latitude = 51.48;
    longitude = 7.22;
  # standalone compositor
  # a must have if your use the modesettig driver for xorg
  };
}