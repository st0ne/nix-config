{ pkgs, ... }:

let
  setupBasic = ''
    # Basic: {{{
      # 256 colors for vim
      set -g default-terminal "screen-256color"
    # }}}
  '';
  setupPowerline = ''
    # Powerline {{{
      # load powerline
      source '${pkgs.python37Packages.powerline}/share/tmux/powerline.conf'
    # }}}
  '';
  setupBindings = ''
    # Bindings: {{{
      ## load testconfig
      bind r source-file /tmp/tmux.conf \; display "Config loaded!"

      ## window
      # custom split key (like i3)
      bind v split-window -v -c '#{pane_current_path}'
      bind b split-window -h -c '#{pane_current_path}'
      # create new window in current path
      bind c new-window -c '#{pane_current_path}'
      # extend vim-like window bindings
      bind H next-window
      bind J swap-window -t -1
      bind K swap-window -t +1
      bind L previous-window

      # pane
      # vim-like pane navigation
      #bind -n C-h select-pane -L
      #bind -n C-j select-pane -D
      #bind -n C-k select-pane -U
      #bind -n C-l select-pane -R
      # vim-like window movement/setup
      #bind -n C-H next-window
      #bind -n C-J swap-window -t -1
      #bind -n C-K swap-window -t +1
      #bind -n C-L previous-window
    # }}}
  '';
in

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
        ${setupBasic}
        ${setupPowerline}
        ${setupBindings}
      '';
    };

    environment.systemPackages = with pkgs; [
      python37Packages.powerline
    ];
  }
#  vim:foldmethod=marker:foldlevel=0
