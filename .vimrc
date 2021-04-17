source $VIMRUNTIME/defaults.vim

colorscheme gruvbox
set background=dark
syntax on
set number
set expandtab
set tabstop=2
set shiftwidth=2
set hls is

" NERDTree
map <C-a><C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
au VimEnter * NERDTreeToggle

" Highlight non-ascii characters
map <C-a><C-a> /[^\x00-\x7F]<CR>

" Set up clipboard
" map <C-c> :.w !pbcopy<CR><CR>
" map <C-v> :r !pbpaste<CR>
" set clipboard=unnamedplus
set clipboard=unnamed

let g:user_emmet_leader_key='<Tab>'

" Backup
set backup
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set writebackup
set backupcopy=yes
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M:%S")

" Filetype
au BufRead,BufNewFile *.theme set filetype=php
au BufRead,BufNewFile *.html.twig set filetype=html

set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·,nbsp:↔,conceal:¬
set list

set foldmethod=manual
let g:PHP_vintage_case_default_indent=1 " Change php switch case formating

