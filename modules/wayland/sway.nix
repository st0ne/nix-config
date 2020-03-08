{ config, lib, pkgs, ... }:

{
  imports = [ ./. ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock # lockscreen
      swayidle
      xwayland # for legacy apps
      waybar # status bar
      mako # notification daemon
      kanshi # autorandr
    ];
  };
  programs.light.enable = true;
}
