{ pkgs, ... }:

# WIP
# enable zsh
# ref: https://grml.org/zsh/

{
  programs.zsh = {
      enable = true;
      interactiveShellInit =
''
    source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    ## alias
    alias ssh='TERM=xterm ssh'
    ## fix
    # remove funktion name conflict with translate-shell
    unfunction trans
'';
    promptInit = ""; # otherwise it'll override the grml prompt
      autosuggestions = {
        enable = true;
      };
      syntaxHighlighting.enable = true;
  };

  environment.systemPackages = with pkgs; [
    grml-zsh-config
    antibody
  ];
}
