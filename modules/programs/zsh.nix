{ lib, pkgs, ... }:

let
  # plugins {{{
    zshPlugins =
      ''
        zsh-users/zsh-autosuggestions
        zdharma/fast-syntax-highlighting
        zdharma/history-search-multi-word
      '';
      zshPluginsFile = "zsh_plugins.txt";
  # }}}
  # prompt {{{
    # poweline-go modules and flags
    modulesLeft = ["nix-shell" "venv" "user" "host" "ssh" "cwd" "perms" "hg" "jobs" "exit" "root" "vgo"];
    modulesRight = ["git"];
    flags = ["colorize-hostname" "condensed"];

  # }}}
  # shell init {{{
  ## grml-lovers
  # ref:  https://grml.org/zsh/
  initGrml = ''
    source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    # remove funktion name conflict with translate-shell
    unfunction trans
  '';
  ## powerline-go
  initPowerline = ''
    export HOME=/home/$USER #BUG

    function powerline_precmd() {
      eval "$(powerline-go -error $? -shell zsh -eval \
      -modules ${lib.strings.concatStringsSep "," modulesLeft} \
      -modules-right ${lib.strings.concatStringsSep "," modulesRight} \
      ${lib.strings.concatMapStringsSep " " (flag: "-" + flag) flags})"
    }

    function install_powerline_precmd() {
      for s in "$\{precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
          return
        fi
      done
      precmd_functions+=(powerline_precmd)
    }

    install_powerline_precmd
  '';
  ## antibody plugin manager
  initAntibody = ''
    source <(antibody init)
    # persistent plugins
    antibody bundle < /etc/${zshPluginsFile}
    # temporary
    if [ -f /tmp/$USER_${zshPluginsFile} ];then
      if [ `stat -c '%U' /tmp/$USER_${zshPluginsFile}` = $USER ]; then
        antibody bundle < /tmp/$USER_${zshPluginsFile}
      else
        echo "/tmp/$USER_${zshPluginsFile}: wrong user permission!"
      fi
    fi
  '';
  # }}}
in
  {
    programs.zsh = {
      enable = true;
      interactiveShellInit = ''
        ${initGrml}
        ${initPowerline}
        ${initAntibody}
      '';
      shellAliases = {
        ssh = "TERM=xterm ssh";
      };
    };

    environment = {
      etc."zsh_plugins.txt" = {
        text = zshPlugins;
      };
      systemPackages = with pkgs; [
        grml-zsh-config
        powerline-go
        antibody
      ];
    };
  }
# vim:foldmethod=marker:foldlevel=0
