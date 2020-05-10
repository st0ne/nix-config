{ lib, pkgs, ... }:
let
  bashCompletion = ''
    # Completion {{{
    # Check whether we're running a version of Bash that has support for
    # programmable completion. If we do, enable all modules installed in
    # the system and user profile in obsolete /etc/bash_completion.d/
    # directories. Bash loads completions in all
    # $XDG_DATA_DIRS/bash-completion/completions/
    # on demand, so they do not need to be sourced here.
    if shopt -q progcomp &>/dev/null; then
      . "${pkgs.bash-completion}/etc/profile.d/bash_completion.sh"
      nullglobStatus=$(shopt -p nullglob)
      shopt -s nullglob
      for p in $NIX_PROFILES; do
        for m in "$p/etc/bash_completion.d/"*; do
          . $m
        done
      done
      eval "$nullglobStatus"
      unset nullglobStatus p m
    fi
    # }}}
  '';
  bashPrompt = ''
    # Prompt {{{
    export PS1="\n\[\033[1;37m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] "
    # }}}
  '';
in
{
  programs.bash = {
    enable = true;
    initExtra = ''
      ${bashCompletion}
      ${bashPrompt}
    '';
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "reboot"
      "shutdown"
    ];
    shellAliases = {
      ssh = "TERM=xterm-color ssh";
    };
    sessionVariables = {
      # grep color
      GREP_COLORS = "auto";
    };
  };
}
# vim:foldmethod=marker:foldlevel=0
