{ lib, ... }:

# overlay for HiDPI (High Dots Per Inch) displays
# optimized for 3840x2160 resolution

{
  # choose a bigger font for the system console
  i18n.consoleFont = "latarcyrheb-sun32";
  environment.variables = {
    # scale Qt applications
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
  # force high DPI setting
  fonts.fontconfig.dpi = lib.mkDefault 192;
}
