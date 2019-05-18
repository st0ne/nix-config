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
        lightdm = {
          enable = lib.mkDefault true;
          greeters = {
            gtk = {
              enable = lib.mkDefault true;
              cursorTheme = {
                size = 48;
              };
            };
          };
        };
      };
      desktopManager = {
        xterm.enable = false;
        # enable gnome as fallback Desktop environment
        gnome3.enable = true;
        default = "none";
      };
    };
    # adjusts the color temperature of your screen at night
    redshift = {
      enable = lib.mkDefault true;
      #provider = "geoclue2";
      # hard code geolocation
      # welcome to Bochum :)
      latitude = "51.48";
      longitude = "7.22";
    };
    # standalone compositor
    # a must have if your use the modesettig driver for xorg
    compton  = {
      enable = lib.mkDefault true;
      backend = lib.mkDefault "glx";
    };
  };
}