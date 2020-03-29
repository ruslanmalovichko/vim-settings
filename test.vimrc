" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change:  2019 Dec 17
"
" To use it, copy it to
"        for Unix:  ~/.vimrc
"       for Amiga:  s:.vimrc
"  for MS-Windows:  $VIM\_vimrc
"       for Haiku:  ~/config/settings/vim/vimrc
"     for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile  " keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'

" Themes
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

colorscheme gruvbox
set background=dark
syntax on
set number
set expandtab
set tabstop=2
set shiftwidth=2
set hls is

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
au VimEnter * NERDTreeToggle

" Highlight non-ascii characters
map <C-a> /[^\x00-\x7F]<CR>

" Set up clipboard
map <C-c> :.w !pbcopy<CR><CR>
map <C-v> :r !pbpaste<CR>

set backup

set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

set writebackup

set backupcopy=yes

au BufWritePre * let &bex = '@' . strftime("%F.%H:%M:%S")

" highlight NonText guifg=#4a4a59
" highlight SpecialKey guifg=#4a4a59

" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·,nbsp:↔
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·,nbsp:↔,conceal:¬
set list

set foldmethod=manual
