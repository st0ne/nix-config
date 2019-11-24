{ lib, pkgs, ... }:

let
  # powerline-go prompt {{{
  modules = ["nix-shell" "venv" "user" "host" "ssh" "cwd" "perms" "hg" "jobs" "exit" "root" "vgo" "git"];
  flags = ["colorize-hostname" "condensed"];
  powerlinePrompt = ''
    export HOME=/home/$USER #BUG
    if [ "$TERM" != "linux" ]
      function fish_prompt
        powerline-go -error $status -shell bare \
        -modules ${lib.strings.concatStringsSep "," modules} \
      ${lib.strings.concatMapStringsSep " " (flag: "-" + flag) flags}
      end
    end
    '';
  # }}}
in
  {
    programs.fish = {
      enable = true;
      promptInit = powerlinePrompt;
      interactiveShellInit = ''
        set fish_greeting
        '';
      shellAliases = {
        ssh = "env TERM=xterm ssh";
      };
    };
    environment.systemPackages = with pkgs; [
      powerline-go
    ];
  }
# vim:foldmethod=marker:foldlevel=0
