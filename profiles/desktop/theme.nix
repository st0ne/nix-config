{ lib, pkgs, ... }:

let
  gtkTheme = pkgs.matcha;
  gtkIcon = pkgs.arc-icon-theme;
  gtkCursor = pkgs.numix-cursor-theme;
  gtkTheme_name = "Matcha-dark-azul";
  gtkIcon_name = "Arc";
  gtkCursor_name = "Numix-Cursor";
in {
  environment = {
    # Make applications find files in <prefix>/share
    pathsToLink = [ "/share" ];
    extraInit = ''
      # GTK3: remove local user overrides (for determinisim, causes hard to find bugs)
      rm -f ~/.config/gtk-3.0/settings.ini
      # QT: remove local user overrides (for determinism, causes hard to find bugs)
      rm -f ~/.config/Trolltech.conf
      # GTK3: add theme to search path for themes
      export XDG_DATA_DIRS="${gtkTheme}/share:$XDG_DATA_DIRS"
      # GTK3: add /etc/xdg/gtk-3.0 to search path for settings.ini
      # We use /etc/xdg/gtk-3.0/settings.ini to set the icon and theme name for GTK 3
      export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
      # QT5: convince it to use our preferred style
      export QT_STYLE_OVERRIDE=gtk2
      '';
    systemPackages = [ gtkTheme gtkIcon gtkCursor pkgs.libsForQt5.qtstyleplugins ];
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
    etc."xdg/Trolltech.conf" = {
      text = ''
      [Qt]
      style=gtk2
      '';
      mode = "444";
    };
  };
}