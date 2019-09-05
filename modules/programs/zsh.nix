{ pkgs, ... }:

let
   zshPlugins =
   ''
   ### pattern
   zsh-users/zsh-autosuggestions
   zdharma/fast-syntax-highlighting
   zdharma/history-search-multi-word

   # theme
   romkatv/powerlevel10k
   '';
   zshPluginsFile = "zsh_plugins.txt";
   # only users should be able to write temporary zsh plugins
   zshPluginsTmpGroup = "users";
in
{
  programs.zsh = {
      enable = true;
      interactiveShellInit =
      ''
      ## grml-lovers
      # https://grml.org/zsh/
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
      # remove funktion name conflict with translate-shell
      unfunction trans

      ## plugins
      source <(antibody init)
      # persistent plugins
      antibody bundle < /etc/${zshPluginsFile}
      # temporary
      if [ -f /tmp/${zshPluginsFile} ];then
        if [ `stat -c '%G' /tmp/${zshPluginsFile}` = ${zshPluginsTmpGroup} ]; then
          antibody bundle < /tmp/${zshPluginsFile}
        else
          echo "/tmp/${zshPluginsFile}: wrong group!"
        fi
      fi

      ## prompt
      # to stupid to normalize home path
      export HOME=/home/$USER
      cd

      ## alias
      '';
      shellAliases = {
        # override environment
        ssh = "TERM=xterm ssh";
      };
  };

  environment = {
    etc."zsh_plugins.txt" = {
      text = zshPlugins;
    };
    systemPackages = with pkgs; [
    powerline-fonts
    #nerdfonts # slow download
    grml-zsh-config
    antibody
    ];
  };
}
