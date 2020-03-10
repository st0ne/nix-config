{ config, pkgs, ... }:

let
  vim = {
    # general {{{
      generalConfig = ''
        " Sets how many lines of history VIM has to remember
        set history=1000

        " Enable filetype plugins
        filetype plugin on
        filetype indent on

        " Fast saving
        nmap <leader>w :w!<cr>

        " :W sudo saves the file
        " (useful for handling the permission-denied error)
        command W w !sudo tee % > /dev/null
      '';
    # }}}
    # UI {{{
    UIConfig = ''
      " colorscheme
      colorscheme molokai

      " Show numbers
      set number

      " Show command
      set showcmd

      " Always show current position
      set ruler

      " Ignore case when searching
      set ignorecase

      " When searching try to be smart about cases
      set smartcase

      " Highlight search results
      set hlsearch

      " Makes search act like search in modern browsers
      set incsearch

      " Disable highlight when <leader><cr> is pressed
      map <silent> <leader><cr> :noh<cr>

      " Don't redraw while executing macros (good performance config)
      set lazyredraw

      " For regular expressions turn magic on
      set magic

      " Add a bit extra margin to the left, to set the fold range
      "set foldcolumn=1
      '';
    # }}}
  };
in
{
  home-manager.users.sylv.programs.vim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # colorscheme
      molokai
      # syntax
      vim-nix
      # browse
      fzf-vim
      # coc
      coc-git coc-go coc-html coc-json coc-python coc-yaml
      # Go
      vim-go
    ];
    extraConfig = ''
      ${vim.generalConfig}
      ${vim.UIConfig}
    '';
  };
}
#  vim:foldmethod=marker:foldlevel=0
