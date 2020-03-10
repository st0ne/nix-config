{ config, pkgs, ... }:

{
  environment.variables = {
    # Morzilla
    MOZ_ENABLE_WAYLAND = "1";
    # Qt
    QT_QPA_PLATFORM = "wayland";
    # gtk
    #GDK_BACKEND = "wayland";
    # clutter
    CLUTTER_BACKEND = "wayland";
  };
}
