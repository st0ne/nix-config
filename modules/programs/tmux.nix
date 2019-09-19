{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "a";
    extraTmuxConf = ''
      # load powerline
      source '${pkgs.python37Packages.powerline}/share/tmux/powerline.conf'
      # 256 colors for vim
      set -g default-terminal "screen-256color"
      # load testconfig
      bind-key r source-file /tmp/tmux.conf \; display "Config loaded!"
      '';
    };

    environment.systemPackages = with pkgs; [
      python37Packages.powerline
    ];
}
