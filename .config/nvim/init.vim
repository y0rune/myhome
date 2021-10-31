" settings
if has('nvim')
	if ! filereadable(system('echo -n "$HOME/.config/nvim/autoload/plug.vim"'))
		silent !mkdir -p $HOME/.config/nvim/autoload/
		silent !curl --silent "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
		autocmd VimEnter * PlugInstall
	endif
endif

let mapleader = "\<Space>"
let g:python3_host_prog = expand('/usr/bin/python3')
let g:loaded_python_provider = 0
let g:python_host_prog = ''
set laststatus=2
set autoindent
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set nocompatible
set incsearch
set noshowmode
set cmdheight=1
set encoding=utf-8
set undofile
set incsearch
set scrolloff=8
set t_BE=
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
filetype plugin indent on
syntax on

" plugins
call plug#begin('~/.config/nvim/plugged')
    " Markdown
    Plug 'tpope/vim-markdown'

    " Nerd Tree
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'nmante/vim-latex-live-preview'

    " Goyo plugin for writing mutt mail
    Plug 'junegunn/goyo.vim'

    " Themes
    Plug 'gruvbox-community/gruvbox', { 'as': 'gruvbox'}

    " Fzf plugin
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'

    " CSS
    Plug 'ap/vim-css-color'

    " coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " PyRight
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

    " Ansible yaml
    Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
    Plug 'Yggdroot/indentLine'

    " coc-cpp coc-c
    " emerge dev-util/ccls

    " Multiple cursors
    Plug 'terryma/vim-multiple-cursors'

    " Enable gentoo-syntax in vim
    Plug 'gentoo/gentoo-syntax'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'
call plug#end()

" Disable by default indent line
" let g:indentLine_enabled = 0

" Enable by default indent line in files
autocmd BufRead,BufNewFile *.yaml let g:indentLine_enabled = 1
autocmd BufRead,BufNewFile *.yaml let g:indentLine_char = '⦙'

" Instalation coc extentions
let g:coc_global_extensions = ['coc-solargraph', 'coc-go', 'coc-yaml', 'coc-pyright', 'coc-json' , 'coc-markdownlint' , 'coc-sh', 'coc-prettier', 'coc-diagnostic', 'coc-perl']

inoremap <silent><expr> <Nul> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart

" Commentry
xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine

" Tab
vnoremap <Tab> >
vnoremap <S-Tab> <

" Status-line
set statusline=
set statusline+=%#IncSearch#
set statusline+=\ %y
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
set statusline+=%#Search#
set statusline+=\ %l/%L
set statusline+=\ [%c]

" ansible
let g:ansible_extra_keywords_highlight = 1
au BufRead,BufNewFile *.yml set filetype=yaml.ansible

" fzf
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/\.local/share/nvim/*" -not -path "./Library/*" '
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindCurrentWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(expand('<cword>')), 1, <bang>0)
set grepprg=rg\ --vimgrep

nmap <Leader>e :Buffers<CR>
nmap <Leader>q :Rg<CR>
nmap <Leader>w :Files<CR>

" Resize window
nnoremap <C-L> :vertical resize +5<CR>
nnoremap <C-H> :vertical resize -5<CR>
nnoremap <C-J> :res +5<CR>
nnoremap <C-K> :res -5<CR>

" Split window
nnoremap _ :vsp <CR>
nnoremap - :split <CR>

" Reload file
nnoremap <F5> :edit <CR>
nnoremap <Leader><F5> :edit! <CR>

" livepreviewer
let g:livepreview_previewer = 'mupdf'

" markdown preview
let g:mkdp_browser = '/home/yorune/.local/bin/browser-x'
let g:mkdp_echo_preview_url = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_minlines = 1
autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

au BufNewFile,BufRead *.conf setfiletype conf

" line numbers
set number
set ruler
set title

" indent
set backspace=indent,eol,start
set shiftwidth=4
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" editing
runtime! macros/matchit.vim
set backspace=indent,eol,start

" visual feedback
set laststatus=2
set showmode
set showcmd

" off mouse
set mouse-=a

" disable pcspkr beep
set visualbell
set t_vb=

" searching
set smartcase
set ic

" cursor
let &t_SI = "\<esc>[6 q"
let &t_EI = "\<esc>[2 q"

" Enable show hidden in NerdTree
let NERDTreeShowHidden=1

" multiple cursors
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" colors
colorscheme gruvbox
let g:gruvbox_invert_selection='0'
set background=dark
"hi Normal ctermbg=NONE
hi Pmenu      ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel   ctermfg=NONE ctermbg=246 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
hi CursorLine cterm=NONE   term=NONE   ctermbg=NONE    guibg=NONE
hi CursorLine ctermbg=235
hi DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
hi DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
hi DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
hi DiffText   cterm=BOLD ctermfg=NONE ctermbg=23

" columne
set textwidth=80
set colorcolumn=80
" highlight ColorColumn ctermbg=235
highlight ColorColumn ctermbg=236

" map
nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>
vnoremap F <C-v>$A
vnoremap f <C-v>0I
nnoremap ee :!mupdf $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
map <C-d> :NERDTreeToggle<CR>
nnoremap <silent> <C-t> :tabnew <CR>
nnoremap <F11> :Goyo <CR>
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>
nnoremap K :tabprevious<CR>
nnoremap J :tabnext<CR>

"" Moving line up or down using alt
nnoremap <A-Up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

nnoremap Ż :m-2<CR>
nnoremap ∆ :m+<CR>
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap Ż :m '<-2<CR>gv=gv

nnoremap <A-k> :m-2<CR>
nnoremap <A-j> :m+<CR>
inoremap <A-k> <Esc>:m-2<CR>
inoremap <A-j> <Esc>:m+<CR>
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

map <F3> :setlocal spell! spelllang=en_gb<CR>
map <F4> :setlocal spell! spelllang=pl<CR>

" Copy into system
noremap <Leader>y "*y
noremap <Leader>p "*p

" Code
map <F12> :w<CR>:terminal ~/.local/bin/debugger '%:p'<CR>
map <Leader>, :CocAction<CR>
map <Leader><Tab> Vgaip= <CR>
nnoremap <leader>x :!chmod +x %<CR>

" Python
autocmd BufRead,BufNewFile *.py set textwidth=0
autocmd BufRead,BufNewFile *.py set fo-=t

" latex
let g:tex_flavor = "latex"
autocmd BufWritePost *.tex silent! execute "!pdflatex --shell-escape -synctex=1 -interaction=nonstopmode % > /dev/null " | redraw!
autocmd BufWritePost *.tex silent! execute "!latexmk -pdf -silent % > /dev/null" | redraw!
autocmd BufWritePost *.tex silent! execute "!sudo rm -rf *.fls *.ilg *.nav *.snm *.toc *.idx *.lof *.lot *.synctex.gz *.aux *.fdb_latexmk *.fls *.log *.out > /dev/null" | redraw!
autocmd BufWritePost *.tex silent! execute "!sudo pkill -HUP mupdf > /dev/null" | redraw!

" mutt
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e
