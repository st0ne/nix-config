{ config, ... }:

{
  imports = [
    ./.
    ../../extern/home-manager.nix
  ];

  home-manager.users.sylv = {
    programs = {
      git = {
        enable = true;
        userName = config.users.users.sylv.description;
        userEmail = "sylv@sylv.io";
        aliases = {
          # ref: https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs
          lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
          tree = "log --graph --simplify-by-decoration --all --oneline";
          adog = "log --all --decorate --oneline --graph";
        };
        ignores = [ "*~" "*.swp" ];
        extraConfig = {
          uploadpack.allowAnySHA1InWant = true;
        };
      };
      termite = {
        enable = true;
        audibleBell = false;
        clickableUrl = true;
        dynamicTitle = true;
        fullscreen = false;
        mouseAutohide = false;
        scrollOnOutput = false;
        scrollOnKeystroke = true;
        searchWrap = true;
        urgentOnBell = true;
        scrollbackLines = 10000;
        cursorBlink = "system";
        scrollbar = "off";
        backgroundColor = "rgba(0, 0, 0, 0.8)";
        cursorColor = "#b7b8b9";
        cursorForegroundColor = "#b7b8b9";
        foregroundColor = "#ffffff";
        foregroundBoldColor = "#ffffff";
        highlightColor = "#2f2f2f";
        colorsExtra = ''
          # black
          color0  = #0c0d0e
          color8  = #737475

          # red
          color1  = #e31a1c
          color9  = #e31a1c

          # green
          color2  = #31a354
          color10 = #31a354

          # yellow
          color3  = #dca060
          color11 = #dca060

          # blue
          color4  = #3182bd
          color12 = #3182bd

          # magenta
          color5  = #756bb1
          color13 = #756bb1

          # cyan
          color6  = #80b1d3
          color14 = #80b1d3

          # white
          color7  = #b7b8b9
          color15 = #fcfdfe
          '';
      };
    };
  };
}
