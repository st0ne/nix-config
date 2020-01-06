{ pkgs, ... }:

let
  learningMode = ''
    " learning: {{{
    " no arrow keys
    noremap  <Up> <NOP>
    noremap  <Down> <NOP>
    noremap  <Left> <NOP>
    noremap  <Right> <NOP>
    " }}}
  '';
  setupBasic =''
    " General {{{
    " enter the current millenium
    set nocompatible

    " Sets how many lines of history VIM has to remember
    set history=500

    " Enable filetype plugins
    filetype plugin on
    filetype indent on

    " Fast saving
    nmap <leader>w :w!<cr>

    " :W sudo saves the file
    " (useful for handling the permission-denied error)
    command W w !sudo tee % > /dev/null

    " }}}
    " UI {{{
    " Turn on the WiLd menu
    set wildmenu

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

    " Show matching brackets when text indicator is over them
    set showmatch
    " How many tenths of a second to blink when matching brackets
    set mat=2

    " Add a bit extra margin to the left, to set the fold range
    "set foldcolumn=1
    " }}}
    " Syntax {{{
    " Enable syntax highlighting
    syntax enable

    " Enable 256 colors palette
    set t_Co=256

    " dark background as default
    set background=dark

    " Set utf8 as standard encoding and en_US as the standard language
    set encoding=utf8

    " Use Unix as the standard file type
    set ffs=unix,dos,mac

    " highlight TODO,XXX,FIXME
    hi Todo ctermbg=lightgreen cterm=italic ctermfg=black
    " }}}
    " Backup {{{
    " Turn backup off, since most stuff is in SVN, git et.c anyway...
    set nobackup
    set nowb
    set noswapfile
    " }}}
    " Spaces {{{
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs ;)
    set smarttab

    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    " set display mode of unwanted characters
    set listchars=tab:>-,nbsp:_,trail:•

    set ai "Auto indent
    set si "Smart indent
    set wrap "Wrap lines
    " }}}
    " Movement {{{

    " Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Close the current buffer
    map <leader>bd :Bclose<cr>:tabclose<cr>gT

    " Close all the buffers
    map <leader>ba :bufdo bd<cr>

    map <leader>l :bnext<cr>
    map <leader>h :bprevious<cr>

    " Useful mappings for managing tabs
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove<cr>
    map <leader>t<leader> :tabnext<cr>

    " Opens a new tab with the current buffer's path
    " Super useful when editing files in the same directory
    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

    " Switch CWD to the directory of the open buffer
    map <leader>cd :cd %:p:h<cr>:pwd<cr>
    " }}}
    " Fold {{{
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
    " Editing {{{
    " Delete trailing white space on save
    func! DeleteTrailingWS()
      exe "normal mz"
      %s/\s\+$//ge
      exe "normal `z"
    endfunc
    autocmd BufWrite *.md :call DeleteTrailingWS()
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite *.go :call DeleteTrailingWS()
    autocmd BufWrite *.nix :call DeleteTrailingWS()
    " }}}
    " Spell checking {{{
    " Pressing ,ss will toggle and untoggle spell checking
    map <leader>ss :setlocal spell!<cr>

    " Shortcuts using <leader>
    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=
    " }}}
    " Misc {{{
    " Remove the Windows ^M - when the encodings gets messed up
    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

    " Toggle paste mode on and off
    map <leader>pp :setlocal paste!<cr>
    " }}}
    " Filetype {{{
    " Mics {{{
    " misc languages
    let perl_fold=1
    let perl_extended_vars=1
    let sh_fold_enable=1
    let php_folding=1
    let ruby_fold=1
    let xml_syntax_folding=1
    " }}}
    " Python {{{
    let python_highlight_all = 1
    au FileType python syn keyword pythonDecorator True None False self

    au BufNewFile,BufRead *.jinja set syntax=htmljinja
    au BufNewFile,BufRead *.mako set ft=mako

    au FileType python map <buffer> F :set foldmethod=indent<cr>

    au FileType python inoremap <buffer> $r return
    au FileType python inoremap <buffer> $i import
    au FileType python inoremap <buffer> $p print
    au FileType python inoremap <buffer> $f #--- <esc>a
    au FileType python map <buffer> <leader>1 /class
    au FileType python map <buffer> <leader>2 /def
    au FileType python map <buffer> <leader>C ?class
    au FileType python map <buffer> <leader>D ?def
    au FileType python set cindent
    au FileType python set cinkeys-=0#
    au FileType python set indentkeys-=0#
    " }}}
    " JavaScript {{{
    au FileType javascript call JavaScriptFold()
    au FileType javascript setl fen
    au FileType javascript setl nocindent

    au FileType javascript imap <c-t> $log();<esc>hi
    au FileType javascript imap <c-a> alert();<esc>hi

    au FileType javascript inoremap <buffer> $r return
    au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

    function! JavaScriptFold()
      setl foldmethod=syntax
      setl foldlevelstart=1
      syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

      function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', \'\')
      endfunction
      setl foldtext=FoldText()
    endfunction
    " }}}
    " Shell {{{
    if exists('$TMUX')
      set term=screen-256color
    endif
    " }}}
    " File format {{{
    " yaml
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    " }}}
    " }}}
  '';
  setupPlugins = ''
    " Colorscheme {{{
    " molokai
    colorscheme molokai
    " }}}
    " ALE {{{
    let g:ale_sign_column_always = 1
    " }}}
    " neocomplete {{{
    let g:neocomplete#enable_at_startup = 1
    " }}}
    " airline {{{
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled = 1
    set laststatus=2 " Always display the statusline in all windows
    set showtabline=2 " Always display the tabline, even if there is only one tab
    set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
    " }}}
    " NERDtree {{{
    "map <C-n> :NERDTreeToggle<CR>
    " General properties
    let NERDTreeDirArrows=1
    let NERDTreeMinimalUI=1
    let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
    let NERDTreeWinSize = 35

    " Make sure that when NT root is changed, Vim's pwd is also updated
    let NERDTreeChDirMode = 2
    let NERDTreeShowLineNumbers = 1
    let NERDTreeAutoCenter = 1

    " Open NERDTree on startup, when no file has been specified
    "autocmd VimEnter * if !argc() | NERDTree | endif
    " }}}
    " Tagbar {{{
    " Toogle on/off
    "<C-m> :TagbarToggle<CR>
    " context-based definitions
    " Go {{{
    " auto open on go files
    "autocmd VimEnter * nested :call tagbar#autoopen(1)

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
    " vim-fugitive {{{
    nmap <leader>gb :Gblame<cr>
    nmap <leader>gs :Gstatus<cr>
    nmap <leader>gc :Gcommit -v<cr>
    nmap <leader>ga :Git add -p<cr>
    nmap <leader>gm :Gcommit --amend<cr>
    nmap <leader>gp :Gpush<cr>
    nmap <leader>gd :Gdiff<cr>
    nmap <leader>gw :Gwrite<cr>
    " }}}
    " vim-go {{{
    " no template
    let g:go_template_autocreate = 0

    " definition to search
    let g:go_decls_includes = "func,type"

    " Go to definition
    let g:go_def_mode='gopls'

    " Automatically get signature/type info for object under cursor
    let g:go_info_mode = 'gopls'
    let g:go_auto_type_info = 1

    let g:go_fmt_fail_silently = 1
    let g:go_fmt_command = "gofmt" "Explicited the formater plugin (gofmt, goimports, goreturn...)

    " jump between errors
    map <C-n> :cnext<CR>
    map <C-m> :cprevious<CR>
    "nnoremap <leader>a :cclose<CR>

    " syntax-highlighting
    let g:go_highlight_types       = 1
    let g:go_highlight_fields      = 1
    let g:go_highlight_functions   = 1
    let g:go_highlight_methods     = 1
    let g:go_highlight_operators   = 1
    let g:go_highlight_extra_types = 1


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
in
{
  home-manager.users.sylv.programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # colorscheme
      molokai
      # syntax
      vim-nix
      # UI
      vim-airline vim-airline-themes nerdtree Tagbar
      # misc
      ale gitgutter vim-fugitive vim-go neocomplete ctrlp
    ];
    extraConfig = ''
      ${learningMode}
      ${setupBasic}
      ${setupPlugins}
    '';
  };
  environment.systemPackages = with pkgs; [
    python37Packages.powerline ctags
    gotags gotools golangci-lint go-langserver
  ];
}
#  vim:foldmethod=marker:foldlevel=0
