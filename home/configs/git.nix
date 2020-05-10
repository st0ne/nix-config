{ pkgs, ... }:
let
  creds = import ../../users/sylv/secrets/creds.nix;
in
{
  programs.git = {
    enable = true;
    userName = "sylv";
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
    signing = {
      key = creds.gpgFingerprint;
      signByDefault = true;
    };
  };
}
#  vim:foldmethod=marker:foldlevel=0
