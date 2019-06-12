{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # administation
    nixops
    # organisation
    taskwarrior
    ## cli tools
    pwgen jq yq
    ## coding
    go gcc gnumake cmake guile-ncurses
  ];
}