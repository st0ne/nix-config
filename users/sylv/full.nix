{ config, ... }:

{
  imports = [
    ./.
    ../../extern/home-manager.nix
  ];

  home-manager.users.sylv = {
    programs = {
      git = {
        enable = true;
        userName = config.users.users.sylv.description;
        userEmail = "sylv@sylv.io";
        aliases = {
          # ref: https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs
          lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
          adog = "log --all --decorate --oneline --graph";
        };
        ignores = [ "*~" "*.swp" ];
      };
    };
  };

}
