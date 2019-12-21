{ config, pkgs, ... }:

{
  home-manager.users.sylv.programs.neovim = {
    enable = true;
    viAlias = true;
    plugins = [];
    extraConfig = ''
      ${vim.generalConfig}
      ${vim.UIConfig}
    '';
  };
}
#  vim:foldmethod=marker:foldlevel=0
