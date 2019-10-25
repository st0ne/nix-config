{ config, lib, pkgs, ... }:

with lib;

let
  gtkTheme = pkgs.matcha;
  gtkIcon = pkgs.arc-icon-theme;
  gtkCursor = pkgs.numix-cursor-theme;
  gtkTheme_name = "Matcha-dark-azul";
  gtkIcon_name = "Arc";
  gtkCursor_name = "Numix-Cursor";
  gtkCursor_size = 32;

in
{
  options.host = {
    dpi = mkOption {
      type = types.int;
      default = null;
      description = ''
      monitor DPI
      '';
    };
  };
  config = {
  environment = {
    # Make applications find files in <prefix>/share
    pathsToLink = [ "/share" ];
    extraInit = ''
      # remove local user overrides (for determinisim)
      rm -f ~/.config/gtk-3.0/settings.ini
      rm -f ~/.gtkrc-2.0
      rm -f ~/.config/Trolltech.conf

      # Add configuration path
      export GTK_PATH="/etc/xdg/gtk-3.0:/etc/xdg/gtk-2.0:$GTK_PATH"

      # QT5: convince qt to use gtk themes
      export QT_STYLE_OVERRIDE=gtk2
      '';
    systemPackages = [ gtkTheme gtkIcon gtkCursor pkgs.libsForQt5.qtstyleplugins ];
    # X11
    etc."X11/xinit/Xresources" = {
      text = ''
      Xcursor.theme: ${gtkCursor_name}
      Xcursor.size: ${toString gtkCursor_size}
      '';
      mode = "444";
    };
    etc."xdg/icons/default/index.theme" = {
      text = ''
      [icon theme]
      Inherits=${gtkCursor_name}
      '';
    };
    # GTK3 global theme (widget and icon theme)
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=${gtkTheme_name}
        gtk-icon-theme-name=${gtkIcon_name}
        gtk-cursor-theme-name=${gtkCursor_name}
      '';
      mode = "444";
    };
    etc."xdg/gtk-2.0/gtkrc" = {
      text = ''
      gtk-theme-name="${gtkTheme_name}"
      gtk-icon-theme-name="${gtkIcon_name}"
      gtk-cursor-theme-name="${gtkCursor_name}"
      gtk-cursor-theme-size=${toString gtkCursor_size}
      '';
    };
    # QT GTK2 style
    etc."xdg/Trolltech.conf" = {
      text = ''
      [Qt]
      style=gtk2
      '';
      mode = "444";
    };
  };
  # lightdm theme
  services.xserver.displayManager.lightdm.greeters.gtk = {
    theme = {
      name = gtkTheme_name;
      package = gtkTheme;
    };
    iconTheme = {
      name = gtkIcon_name;
      package = gtkIcon;
    };
    cursorTheme = {
      name = gtkCursor_name;
      package = gtkCursor;
    };
  };
  };
}
