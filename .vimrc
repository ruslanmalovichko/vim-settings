source $VIMRUNTIME/defaults.vim

colorscheme gruvbox
set background=dark
syntax on
set number
set tabstop=2
set expandtab
" set softtabstop=2
set shiftwidth=2
set hls is

" NERDTree
" map <C-a><C-n> :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1
" au VimEnter * NERDTreeToggle

" Highlight non-ascii characters
map <C-a><C-a> /[^\x00-\x7F]<CR>

" Set up clipboard
" map <C-c> :.w !pbcopy<CR><CR>
" map <C-v> :r !pbpaste<CR>
" set clipboard=unnamedplus
" set clipboard=unnamed
set clipboard=unnamed,unnamedplus

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
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.html.twig set filetype=html
au BufRead,BufNewFile *.json set filetype=json
" au BufRead,BufNewFile *.ts set filetype=javascript

set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·,nbsp:↔,conceal:¬
set list

set foldmethod=manual
let g:PHP_vintage_case_default_indent=1 " Change php switch case formating

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Remap keys for gotos. Use gd as VSCode
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" By default, numbers with a leading zero are interpreted as octal. Interpret all numbers to decimal.
set nrformats=

" Change Autocomplete settings
" set wildmode=longest,list
set wildmenu
set wildmode=full

" Change max command history storage
set history=10000

" Add %% shortcut for getting path to active catalog. Like %:h<Tab>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Use <cr> to confirm completion
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Settings for netrw
set nocompatible
filetype plugin on

" Enable matchit
set nocompatible
filetype plugin on
runtime macros/matchit.vim

" In ~/.vim/ftplugin/javascript.vim, or somewhere similar.

" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']
" Equivalent to the above.
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

" Settings for macroses in multiple files
set nocompatible
filetype plugin indent on
set hidden
if has("autocmd")
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif

" Create shortcut for disable higlight results once. Use <C-l>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" add Shortcuts for using one &. Run last find and replace with last flags.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" let g:ale_php_phpstan_autoload = 'vendor/autoload.php'
" let g:ale_php_phpstan_autoload = '/media/ruslan/data/docker-projects/icca/vendor/autoload.php'
" let g:ale_php_phpstan_autoload = '/media/ruslan/data/docker-projects/icca'
