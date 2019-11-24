{ lib, pkgs, ... }:

{
  imports = [
    ../../modules/xserver/libinput.nix
  ];
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
  services = {
    xserver = {
      # enable xserver by default
      enable = lib.mkDefault true;
      useGlamor = lib.mkDefault true;
      autoRepeatDelay = lib.mkDefault 300;
      autoRepeatInterval = lib.mkDefault 25;
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
  };
}
