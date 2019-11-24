{ lib, pkgs, ... }:

let
  # powerline-go {{{
  modules = ["nix-shell" "venv" "user" "host" "ssh" "cwd" "perms" "hg" "jobs" "root" "vgo" "git" "exit"];
  flags = ["colorize-hostname" "condensed"];
  powerlinePrompt = ''
    export HOME=/home/$USER #BUG
    function _update_ps1() {
        PS1="$(powerline-go -error $? \
        -modules ${lib.strings.concatStringsSep "," modules} \
        ${lib.strings.concatMapStringsSep " " (flag: "-" + flag) flags})"
    }
    if [ "$TERM" != "linux" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
  '';
  # }}}

in
  {
    programs.bash = {
      enableCompletion = true;
      vteIntegration = true;
      promptInit = powerlinePrompt;
      shellAliases = {
        ssh = "TERM=xterm ssh";
      };
    };
    environment ={
      variables = {
        # grep color
        GREP_COLORS = "auto";
        # less colors
        #LESS_TERMCAP_mb = "$'\e[1;31m'";
        #LESS_TERMCAP_md = "$'\e[1;31m'";
        #LESS_TERMCAP_me = "$'\e[0m'";
        #LESS_TERMCAP_se = "$'\e[0m'";
        #LESS_TERMCAP_so = "$'\e[01;33m'";
        #LESS_TERMCAP_ue = "$'\e[0m'";
        #LESS_TERMCAP_us = "$'\e[1;4;32m'";
      };
      systemPackages = with pkgs; [
        grml-zsh-config
        powerline-go
        antibody
      ];
    };
  }
# vim:foldmethod=marker:foldlevel=0
