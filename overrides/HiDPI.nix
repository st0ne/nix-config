{ config, lib, ... }:

# overlay for HiDPI (High Dots Per Inch) displays
# optimized for 3840x2160 resolution
let
  dpi = config.host.dpi;
  cursorSize = 64;
in {
  # choose a bigger font for the system console
  i18n.consoleFont = "latarcyrheb-sun32";
  environment.variables = {
    # scale Qt applications
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # GTK
    GDK_SCALE= "2";
    GDK_DPI_SCALE= "0.5";
    # cursor
    XCURSOR_SIZE= "${toString cursorSize}";
  };
  # force high DPI setting
  fonts.fontconfig.dpi = lib.mkDefault dpi;
  # bootloader resolution
  boot.loader.grub.gfxmodeEfi = "1024x768";
  services.xserver = {
    dpi = dpi;
    displayManager.lightdm.greeters.gtk = {
      extraConfig = ''
      xft-dpi=${toString dpi}
      '';
      cursorTheme.size = cursorSize;
    };
  };
}
