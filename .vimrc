if has('nvim')
  let g:neovim = 1
endif

if exists('g:neovim')
  " Neovim settings
  " Check if nvim was started with -Vifm parameter
  " if index(v:argv, '-Vifm') >= 0
  "   autocmd VimEnter * Vifm
  " endif

  if argc() == 0 && index(v:argv, '-Vifm') >= 0
    autocmd VimEnter * Vifm
  endif

  " Enable bold and italic fonts
  set t_ZH=[3m
  set t_ZR=[23m
  set t_md=[1m
  set t_me=[0m

  " Backup
  set undodir=~/.config/nvim/undo//
  set backupdir=~/.config/nvim/backup//
  set directory=~/.config/nvim/swp//

  " Return cursor to last position
  augroup remember_cursor_position
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
  augroup END

  " CopilotChat
  " Default model 9: * GPT-4.1 (copilot:gpt-4.1)
  lua require("CopilotChat").setup({})

  lua vim.keymap.set('n', '<Space>ccq', function() local input = vim.fn.input("Quick Chat: ") if input ~= "" then require("CopilotChat").ask(input, {selection = require("CopilotChat.select").buffer}) end end, {desc = "CopilotChat - Quick chat"})
else
  " vim settings
  " Connect /usr/share/vim/vim91/defaults.vim
  source $VIMRUNTIME/defaults.vim

  " Backup
  set undodir=~/.vim/undo//
  set backupdir=~/.vim/backup//
  set directory=~/.vim/swp//
endif

set nocompatible
" filetype plugin on
filetype plugin indent on

" let g:nord_bold = 1
" let g:nord_italic = 1
" let g:nord_italic_comments = 1
" let g:nord_underline = 1

if (has("termguicolors"))
  set termguicolors
endif
set runtimepath+=~/.vim/plugins/start/nordtheme-vim
packadd! nordtheme-vim
colorscheme nord

" colorscheme gruvbox
set background=dark
" set background=light
syntax on
syntax enable
filetype plugin indent on
set number
" set relativenumber " Relative numbers for moving like 3k
set tabstop=2
set expandtab
set softtabstop=2 " Do not use tabs
set shiftwidth=2
set cursorline
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
" map <C-c> :.w !xclip -selection clipboard<CR><CR>
" map <C-v> :r !xclip -selection clipboard -o<CR>
" set clipboard=unnamedplus
" set clipboard=unnamed
" set clipboard=unnamed,unnamedplus
if has('clipboard')
  set clipboard=unnamedplus
endif

let g:user_emmet_leader_key='<Tab>'

" Backup
set backup
set writebackup
set backupcopy=yes
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M:%S")

" Filetype
au BufRead,BufNewFile *.theme set filetype=php
au BufRead,BufNewFile *.module set filetype=php
" au BufRead,BufNewFile *.html.twig set filetype=html
au BufRead,BufNewFile *.json set filetype=json
" au BufRead,BufNewFile *.ts set filetype=javascript

set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·,nbsp:↔,conceal:¬
set list

set foldmethod=manual
let g:PHP_vintage_case_default_indent=1 " Change php switch case formating

" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap < <><left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

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
" When using : and <Tab>, show all matches
set wildmenu
set wildmode=full

" Change max command history storage
set history=10000

" Add %% shortcut for getting path to active catalog. Like %:h<Tab>
" Use :%% - current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Use <cr> to confirm completion
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Enable matchit
" For example, use % to jump between function and class in PHP
runtime macros/matchit.vim

" In ~/.vim/ftplugin/javascript.vim, or somewhere similar.

" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']
" Equivalent to the above.
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

" Settings for macroses in multiple files
filetype plugin indent on
set hidden
if has("autocmd")
  " when onpening a file with .rb extension, set tabstop to 2 spaces
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

" dotnet
" let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_use_net6 = 1

" change copilot keybindings
imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)
imap <silent> <C-\> <Plug>(copilot-dismiss)

let mapleader = " "

" Fast exit insert mode
" inoremap jk <Esc>

" Open NERDTree on startup
" nnoremap <leader>n :NERDTreeToggle<CR>

" Switch theme
" nnoremap <leader>tt :source ~/.config/nvim/configs/theme.vim<CR>

" Remove trailing whitespace on save
" autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * silent! %s/\s\+$//e

" Automatically wrap lines for markdown files. For files with .md extension
autocmd FileType markdown setlocal wrap linebreak

" if $TERM_PROGRAM ==# 'alacritty'
"   " Alacritty settings
"   set guifont=JetBrainsMono\ Nerd\ Font:h12
" elseif $TERM_PROGRAM ==# 'WezTerm'
"   " WezTerm settings
"   set guifont=FiraCode\ Nerd\ Font:h12
" elseif $TERM_PROGRAM ==# 'Apple_Terminal'
"   " macOS Terminal settings
" endif

" if $TERM ==# 'xterm-kitty'
"   " In Kitty
" elseif $TERM ==# 'alacritty'
"   " In Alacritty
" elseif $TERM =~# 'xterm'
"   " Usually xterm
" endif

"  Check if running in GUI or terminal
" if has('gui_running') || exists('g:neovide') || exists('g:goneovim')
"   " GUI-Mode (GVim, Neovide, Goneovim)
"
"   " Set font (example for Nerd Fonts)
"   set guifont=JetBrainsMono\ Nerd\ Font:h12
"
"   " More contrast
"   colorscheme nord
"
" else
"   " Terminal-Mode
  " if $TERM ==# 'xterm-kitty'
  "   " In Kitty
  " elseif $TERM ==# 'alacritty'
  "   " In Alacritty
  " elseif $TERM =~# 'xterm'
  "   " Usually xterm
  " endif
" endif

" Change colorscheme by time
" function! ChangeColorschemeByTime()
"   let hour = str2nr(strftime("%H"))
"   if hour >= 7 && hour < 19
"     colorscheme onelight
"     set background=light
"   else
"     colorscheme nord
"     set background=dark
"   endif
" endfunction
"
" autocmd VimEnter * call ChangeColorschemeByTime()
