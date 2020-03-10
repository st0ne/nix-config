{ config, pkgs, ... }:

{
  home-manager.users.sylv.xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" =[ "firefox.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}
#  vim:foldmethod=marker:foldlevel=0
