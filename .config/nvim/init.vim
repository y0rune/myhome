" settings
if ! filereadable(system('echo -n "$HOME/.config/nvim/autoload/plug.vim"'))
	silent !mkdir -p $HOME/.config/nvim/autoload/
	silent !curl --silent "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

let mapleader = ","
set laststatus=2
set shiftwidth=4
set softtabstop=4
set tabstop=4
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
let g:python3_host_prog = expand('/usr/src/python')

" plugins
call plug#begin('~/.config/nvim/plugged')
    " Markdown
    Plug 'tpope/vim-markdown'

    " Nerd Tree
    Plug 'preservim/nerdtree'
    Plug 'nmante/vim-latex-live-preview'

    " Goyo plugin for writing mutt mail
    Plug 'junegunn/goyo.vim'

    " Theme dracula and zenburn
    Plug 'dracula/vim', { 'as': 'dracula'}
    Plug 'jnurmine/Zenburn', { 'as': 'zenburn'}

    " Fzf plugin
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'

    " CSS
    Plug 'ap/vim-css-color'

    " coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " coc for ruby
    Plug 'neoclide/coc-solargraph', {'do': 'gem install solargraph'}

    " coc for python
    Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile; npm i -D npx-run; pip install --user jedi; pip install --user black'}

    " coc for yaml
    Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

    " coc for json
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}

    " coc for markdownlint
    Plug 'fannheyward/coc-markdownlint', {'do': 'yarn install --frozen-lockfile; npm i -D markdownlint --save-dev'}

    " coc for bash
    Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile; npm i -D bash-language-server'}

    " coc for prettier
    Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
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

" fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindCurrentWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(expand('<cword>')), 1, <bang>0)
set grepprg=rg\ --vimgrep
nmap <Leader>f :FZF<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>s :Files<CR>
nmap <Leader>/ :Rg<CR>

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
set expandtab
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

" colors
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
set bg=dark
hi CursorLine cterm=NONE term=NONE ctermbg=NONE guibg=NONE
hi CursorLine ctermbg=235
colorscheme zenburn

" columne
set textwidth=80
set colorcolumn=-3
highlight ColorColumn ctermbg=235

" map
nnoremap S :%s//g<Left><Left>
nnoremap ee :!mupdf $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-t> :tabnew <CR>
nnoremap <F11> :Goyo <CR>
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>

"" Moving line up or down using alt
nnoremap <A-Up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

map <F5> :setlocal spell! spelllang=en_gb<CR>
map <F6> :setlocal spell! spelllang=pl<CR>

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
