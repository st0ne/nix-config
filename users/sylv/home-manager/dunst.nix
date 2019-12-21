{ config, pkgs, ... }:

{
  home-manager.users.sylv.services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment = "left";
        markup = true;
        bounce_freq = 0;
        dmenu = "dmenu -p dunst:";
        follow = "none";
        font = "DejaVu Sans (TTF) 12";
        format = "<b>%s</b>\n%b";
        # geometry [{width}]x{height}][+/-{x}+/-{y}]
        geometry = "950-10+10";
        history_length = 20;
        horizontal_padding = 8;
        idle_threshold = 120;
        ignore_newline = false;
        indicate_hidden = true;
        line_height = 0;
        monitor = 0;
        padding = 8;
        separator_color = "frame";
        separator_height = 1;
        show_age_threshold = 60;
        show_indicators = true;
        shrink = true;
        sort = true;
        startup_notification = false;
        sticky_history = true;
        transparency = 20;
        word_wrap = true;
        frame_width = 3;
        frame_color = "#4C7899";
      };
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };
      urgency_low = {
        background = "#0C0D0E";
        foreground = "#3182BD";
        timeout = 10;
      };
      urgency_normal = {
        background = "#0C0D0E";
        foreground = "#31A354";
        timeout = 20;
      };
      urgency_critical = {
        background = "#0C0D0E";
        foreground = "#E31A1C";
        timeout = 0;
      };
    };
  };
}
