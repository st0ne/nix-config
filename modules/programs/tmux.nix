{ pkgs, ... }:

let
  setupBasic = ''
    # Basic: {{{
      # 256 colors for vim
      set -g default-terminal "screen-256color"
      set-option -sg escape-time 10
    # }}}
  '';
  setupPowerline = ''
    # Powerline {{{
      # load powerline
      source '${pkgs.python37Packages.powerline}/share/tmux/powerline.conf'
    # }}}
  '';
  # powerline config {{{
    configPowerline = ''
      {
      "segments": {
        "right": [
          {
            "function": "powerline.segments.common.time.date",
            "name": "time",
            "args": {
              "format": "%H:%M",
              "istime": true
            }
          },
          {
            "function": "powerline.segments.common.net.hostname",
            "name": "hostname",
            "args": {
              "only_if_ssh": true
            }
          },
          {
            "function": "powerline.segments.tmux.attached_clients"
          }
        ]
      }
      }
    '';
  # }}}
  setupBindings = ''
    # Bindings: {{{
      ## window
      # pane split key in current path
      bind v split-window -v -c '#{pane_current_path}'
      bind b split-window -h -c '#{pane_current_path}'
    # }}}
  '';
  setupRemote = ''
    # Remote {{{
    # Session is considered to be remote when we ssh into host
    if-shell 'test -n "$SSH_CLIENT"' \
        'set-option -g status-position top'
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
      shortcut = "b";
      extraTmuxConf = ''
        ${setupBasic}
        ${setupPowerline}
        ${setupRemote}
        ${setupBindings}
      '';
    };

    environment = {
      etc."xdg/powerline/themes/tmux/default.json" = {
        text = configPowerline;
      };
      systemPackages = with pkgs; [
        python37Packages.powerline
      ];
    };
  }
#  vim:foldmethod=marker:foldlevel=0
