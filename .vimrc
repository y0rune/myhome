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
Plug 'scrooloose/nerdtree', "{ 'on':  'NERDTreeToggle' }
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
set cursorline
set cmdheight=1
let g:livepreview_previewer = 'mupdf'
syntax on
filetype plugin indent on

set encoding=utf-8

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

" disable pcspkr beep
set visualbell
set t_vb=

" searching
set incsearch
set smartcase

" cursor
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

" colors
colorscheme desert
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
nnoremap <F2> :GoRun<CR>

command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" latex
autocmd BufWritePost *.tex silent! execute "!pdflatex --shell-escape -synctex=1 -interaction=nonstopmode % > /dev/null " | redraw!
autocmd BufWritePost *.tex silent! execute "!latexmk -pdf -silent % > /dev/null" | redraw!
autocmd BufWritePost *.tex silent! execute "!sudo rm -rf *.fls *.ilg *.nav *.snm *.toc *.idx *.lof *.lot *.synctex.gz *.aux *.fdb_latexmk *.fls *.log *.out > /dev/null" | redraw!
autocmd BufWritePost *.tex silent! execute "!sudo pkill -HUP mupdf > /dev/null" | redraw!
autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,bf \textbf{}<Esc>T{i
autocmd FileType tex inoremap ,co \coun{}\\<Esc>T{i
autocmd FileType tex inoremap ,nbf \noindent\textbf{}\\<Esc>T{i
autocmd FileType tex inoremap ,noi \noindent<Esc>T{i
autocmd FileType tex inoremap ,ln \par\noindent \line(1,0){400}\<Esc>T{i
autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,li <Enter>\item<Space>
autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,bt {\blindtext}
autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i
