" settings
if ! filereadable(system('echo -n "$HOME/.vim/autoload/plug.vim"'))
	silent !mkdir -p $HOME/.vim/autoload/
	silent !curl --silent "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.vim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

set laststatus=2
set shiftwidth=4
set softtabstop=4
set tabstop=4
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

" plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'nmante/vim-latex-live-preview'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
call plug#end()

" Status-line
set statusline=
set statusline+=%#IncSearch#
set statusline+=\ %y
set statusline+=\ %r
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
set statusline+=%#Search#
set statusline+=\ %l/%L
set statusline+=\ [%c]

set nocompatible
set hlsearch
set incsearch
set noshowmode
set cmdheight=1
syntax on
filetype plugin indent on
set encoding=utf-8

" livepreviewer
let g:livepreview_previewer = 'mupdf'

" markdown preview
let g:mkdp_browser = '/home/yorune/.local/bin/browser-x'
let g:mkdp_echo_preview_url = 1

" line numbers
set number
set ruler
set title

" indent
set backspace=indent,eol,start
set shiftwidth=4
set expandtab

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

" colors
set bg=dark
hi CursorLine cterm=NONE term=NONE ctermbg=NONE guibg=NONE
hi CursorLine ctermbg=235

" map
nnoremap S :%s//g<Left><Left>
nnoremap ee :!mupdf $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-t> :tabnew <CR>
nnoremap <F11> :Goyo <CR>
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

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
