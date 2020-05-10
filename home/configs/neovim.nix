{ config, lib, pkgs, ... }:

let
  settings = with pkgs.vimPlugins; {
    general = {
      config = ''
        " {{{
        set history=1000
        " Set utf8 as standard encoding and en_US as the standard language
        set encoding=utf8
        " Use Unix as the standard file type
        set ffs=unix,dos,mac
        " :W sudo saves the file
        command W w !sudo tee % > /dev/null
        " }}}
      '';
    };
    ui = {
      packages = with pkgs; [ ctags ];
      plugins = [ molokai nerdtree airline Tagbar ];
      config = ''
        " {{{
        " Turn on the Wild menu
        set wildmenu
        """ Basic
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
        set foldcolumn=1
        " 1 tab == 4 spaces
        set shiftwidth=4
        set tabstop=4
        " }}}
        " Theme {{{
        colorscheme molokai
        " dark background as default
        set background=dark
        " }}}
        " airline {{{
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled = 1
        set laststatus=2 " Always display the statusline in all windows
        set showtabline=2 " Always display the tabline, even if there is only one tab
        set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
        " }}}
        " {{{ NERDtree
        map <C-n> :NERDTreeToggle<CR>
        " General properties
        let NERDTreeDirArrows=1
        let NERDTreeMinimalUI=1
        let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
        let NERDTreeWinSize = 35
        "Automatically find and select currently opened file in NERDTree
        let g:nerdtree_tabs_autofind=1
        " Make sure that when NT root is changed, Vim's pwd is also updated
        let NERDTreeChDirMode = 2
        let NERDTreeShowLineNumbers = 1
        let NERDTreeAutoCenter = 1
        " }}}
        " Tagbar {{{
        " Toogle on/off
        map <C-p> :TagbarToggle<CR>
        " context-based definitions
        " auto open on go files
        au FileType go autocmd VimEnter * nested :call tagbar#autoopen(1)
        " go {{{
        let g:tagbar_type_go = {
          \ 'ctagstype' : 'go',
          \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
              \ 't' : 'ctype',
              \ 'n' : 'ntype'
              \ },
              \ 'scope2kind' : {
                \ 'ctype' : 't',
                \ 'ntype' : 'n'
                \ },
                \ 'ctagsbin'  : 'gotags',
                \ 'ctagsargs' : '-sort -silent'
                \ }
        " }}}
        " }}}
      '';
    };
    movement = {
      packages = with pkgs; [ fzf ];
      plugins = [ fzf-vim ];
      config = ''
        " {{{
        " Smart way to move between windows
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l
        " }}}
        " fzf {{{
        map <C-f> :FZF<CR>
        "allow FZF to search hidden 'dot' files
        let $FZF_DEFAULT_COMMAND = "find -L"
        " }}}
      '';
    };
    syntax = {
      #TODO: spellchecking setup
      config = ''
        " syntax {{{
        " Enable filetype plugins
        filetype plugin on
        filetype indent on
        " set display mode of unwanted characters
        set list
        set listchars=tab:>-,nbsp:_,trail:•,extends:>,precedes:<
        " }}}
        " fold {{{
        set foldmethod=syntax
        " space open/closes folds
        nnoremap <space> za
        " enable folding
        set foldenable
        " open most folds by default
        set foldlevelstart=10
        " 3 nested fold max
        set foldnestmax=3
        " }}}
        " spellchecking {{{
        map <leader>ss :setlocal spell!<cr>
        " }}};
      '';
    };
    git = {
      plugins = [ vim-fugitive gitgutter ];
      config = ''
        " {{{
        nmap <leader>gb :Gblame<cr>
        nmap <leader>gs :Gstatus<cr>
        nmap <leader>gc :Gcommit -v<cr>
        nmap <leader>ga :Git add -p<cr>
        nmap <leader>gm :Gcommit --amend<cr>
        nmap <leader>gp :Gpush<cr>
        nmap <leader>gd :Gdiff<cr>
        nmap <leader>gw :Gwrite<cr>
        " }}}
      '';
    };
    Coding = {
      packages = with pkgs; [
        # C/C++
        clang-tools
        # Go
        gotools
        gotags
        golangci-lint
        # Nix
        nixpkgs-fmt
      ]
      ++ (with python3Packages; [ autopep8 black flake8 isort mypy pyflakes ]); #ALE python linter
      plugins = [ ale deoplete-nvim neosnippet neosnippet-snippets vim-go vim-nix ];
      config = ''
        " ALE {{{
        let g:ale_sign_column_always = 1
        let g:airline#extensions#ale#enabled = 1
        " Error and warning signs.
        let g:ale_sign_error = '⤫'
        let g:ale_sign_warning = '⚠'
        let g:ale_linters = {
        \   'go': ['gopls'],
        \}
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'nix': ['nixpkgs-fmt']
        \}
        " }}}
        " deoplete {{{
        let g:deoplete#enable_at_startup = 1
        " }}}
        " Go {{{
        " format
        au FileType go set noexpandtab
        au FileType go set shiftwidth=4
        au FileType go set softtabstop=4
        au FileType go set tabstop=4
        " vim-go
        let g:go_fmt_command = "goimports"
        let g:go_template_autocreate = 0
        let g:go_auto_sameids = 1
        let g:go_auto_type_info = 1
        let g:go_addtags_transform = "snakecase"
        let g:go_snippet_engine = "neosnippet"
        " syntax-highlighting
        let g:go_highlight_types = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_extra_types = 1
        let g:go_highlight_build_constraints = 1
        " key mapping {{{
        au FileType go nmap     gd            <Plug>(go-def)
        au FileType go nmap     <leader>r     <Plug>(go-run)
        au FileType go nmap     <leader>b     <Plug>(go-build)
        au FileType go nmap     <leader>B     :make<CR>
        au FileType go nmap     <leader>t     <Plug>(go-test)
        au FileType go nmap     <leader>c     <Plug>(go-coverage-toggle)
        au FileType go nmap     <leader>e     <Plug>(go-rename)
        au FileType go nmap     <leader>dd    <Plug>(go-def)
        au FileType go nmap     <leader>ds    <Plug>(go-def-split)
        au FileType go nmap     <leader>dv    <Plug>(go-def-vertical)
        au FileType go nmap     <leader>dt    <Plug>(go-def-tab)
        au FileType go nmap     <leader>kk    <Plug>(go-doc)
        au FileType go nmap     <leader>kv    <Plug>(go-doc-vertical)
        au FileType go map      <leader>kb    <Plug>(go-doc-browser)
        au FileType go nmap     <leader>im    <Plug>(go-implements)
        au FileType go nmap     <leader>in    <Plug>(go-info)
        au FileType go nmap     <leader>ip    <Plug>(go-imports)
        au FileType go nmap     <leader>dc    <Plug>(go-decls)
        au FileType go nmap     <leader>dp    <Plug>(go-decls-dir)
        au FileType go nmap     <leader>P     :GoPlay<CR>
        " }}}
        " }}}
      '';
    };
  };

  merge = with lib; { a, f ? lists.flatten, l ? settings }:
    f (attrsets.mapAttrsToList (_: value: optionals (attrsets.hasAttrByPath [ a ] value) value."${a}") l);
  packages = with pkgs; merge { a = "packages"; };
  #pythonPackages = merge { a = "pythonPackages"; };
  plugins = with pkgs.vimPlugins; merge { a = "plugins"; };
  extraConfig = with lib; merge { a = "config"; f = strings.concatStrings; };

in
{
  programs.neovim = {
    #package = pkgs.neovim-unwrapped-nightly;
    inherit plugins extraConfig;
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython = false;
    withPython3 = true;
    extraPythonPackages = (ps: with ps; []);
  };
  home = {
    inherit packages;
  };
}
#  vim:foldmethod=marker:foldlevel=0
