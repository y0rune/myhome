""""""""""""""""""""""""""""""""
" Download vim-plug
""""""""""""""""""""""""""""""""
if has('nvim')
    if ! filereadable(system('echo -n "$HOME/.config/nvim/autoload/plug.vim"'))
        silent !mkdir -p $HOME/.config/nvim/autoload/
        silent !curl --silent "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
        autocmd VimEnter * PlugInstall
    endif
endif

""""""""""""""""""""""""""""""""
" Default settings nvim
""""""""""""""""""""""""""""""""
let g:python3_host_prog = expand('/usr/bin/python3')
let g:loaded_python_provider = 0
let g:python_host_prog = ''
set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set nocompatible
set noshowmode
set noerrorbells
set nowrap
set hidden
set cmdheight=1
set encoding=utf-8
set undofile
set scrolloff=8
set t_BE=
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
filetype plugin indent on
syntax on

" Disable by default indent line
" let g:indentLine_enabled = 0

" ansible
let g:ansible_extra_keywords_highlight = 1

" line numbers
set number
set ruler
set title

" indent
set backspace=indent,eol,start
"set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
set list listchars=tab:\│\ ,trail:·
let g:indentLine_char_list = ['│', '│', '│', '│']

" editing
runtime! macros/matchit.vim

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
set guicursor=
set guicursor+=a:blinkon0
let &t_SI = "\<esc>[6 q"
let &t_SR = "\<esc>[6 q"
let &t_EI = "\<esc>[6 q"

""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""
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
    Plug 'Mofiqul/dracula.nvim'

    " Fzf plugin
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf'

    " CSS
    Plug 'ap/vim-css-color'

    " coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Copilot
    Plug 'github/copilot.vim'

    " PyRight
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

    " Ansible yaml
    Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
    Plug 'Yggdroot/indentLine'

    " GoLang
    Plug 'fatih/vim-go'

    " Multiple cursors
    Plug 'terryma/vim-multiple-cursors'

    " Enable gentoo-syntax in vim
    Plug 'gentoo/gentoo-syntax'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'

    " Git tool
    Plug 'tpope/vim-fugitive'

    " Preetier
    Plug 'prettier/vim-prettier'

    " Debug
    Plug 'puremourning/vimspector'
    Plug 'mfussenegger/nvim-dap'
call plug#end()

" Coc
let g:coc_global_extensions = ['coc-docker', 'coc-java', '@yaegassy/coc-ansible', 'coc-solargraph', 'coc-go', 'coc-yaml', 'coc-pyright', 'coc-json' , 'coc-markdownlint' , 'coc-sh', 'coc-prettier', 'coc-diagnostic', 'coc-perl']

inoremap <silent><expr> <Nul> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Enable show hidden in NerdTree
let NERDTreeShowHidden=1

" latex
let g:tex_flavor = "latex"

" Debug
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]

""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""
"colorscheme gruvbox
" colorscheme default
colorscheme dracula
let g:gruvbox_invert_selection='0'
let g:gruvbox_contrast_dark = 'hard'
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
highlight ColorColumn ctermbg=236

""""""""""""""""""""""""""""""""
" Status Line
""""""""""""""""""""""""""""""""
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

set statusline=
set statusline+=%#IncSearch#
set statusline+=%{&filetype!=#''?'\ \ ['.&filetype.']\ ':'\ '}
set statusline+=%{&modified?'[+]\ ':''}
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
set statusline+=%#warningmsg#
set statusline+=%{StatusDiagnostic()!=#''?'\ '.StatusDiagnostic():''}
set statusline+=%#CursorLineNr#
set statusline+=%{StatuslineGit()}
set statusline+=%#Search#
set statusline+=\ %l/%L
set statusline+=\ [%c]

" Disable godoc keys
let g:go_doc_keywordprg_enabled = 0
set completeopt-=preview

""""""""""""""""""""""""""""""""
" Keyboard shortcuts
""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
nmap <leader>a :CocAction<CR>
nmap <leader>d :CocDiagnostics<CR>
nmap <leader>2 :w!<cr>

" Go to definition
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart

" Adding commentary
xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>c <Plug>CommentaryLine

xmap <C-_> <Plug>Commentary
nmap <C-_> <Plug>Commentary
omap <C-_> <Plug>Commentary
nmap <C-_> <Plug>CommentaryLine

" Better tab
vnoremap <Tab> >
vnoremap <S-Tab> <

" FZF
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

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Tab in the coc to help select right autocomplete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

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

" Better replace
nnoremap <Leader>s :%s//g<Left><Left>
vnoremap <Leader>s :s//g<Left><Left>

" Better adding into begging and ending line
vnoremap F <C-v>$A
vnoremap f <C-v>0I

" Better management of tabs
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>

" Better moving
nnoremap J }
nnoremap K {

" Copy into system
noremap <Leader>y "*y
noremap <Leader>p "*p

" Code
map <Leader><Tab> Vgaip= <CR>

" Multiple cursors
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Others
nnoremap ee :!mupdf $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
map <C-d> :NERDTreeToggle<CR>
nnoremap <silent> <C-t> :tabnew <CR>
nnoremap <F11> :Goyo <CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
map <F3> :setlocal spell! spelllang=en_gb<CR>
map <F4> :setlocal spell! spelllang=pl<CR>

""""""""""""""""""""""""""""""""
" Files
""""""""""""""""""""""""""""""""

" Ansible
au BufRead,BufNewFile *.yaml,*.yml if search('hosts:\|tasks:', 'nw') | set ft=yaml.ansible | endif
au BufWritePre *.yaml,*.yml :Prettier <CR>
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

" Bash
autocmd FileType sh
    \ autocmd BufWritePre <buffer> :Prettier <CR>

" Python
autocmd BufRead,BufNewFile *.py set textwidth=0
autocmd BufRead,BufNewFile *.py set fo-=t

" Newsboat
autocmd BufRead,BufNewFile urls set textwidth=0

" Latex
autocmd BufWritePost *.tex silent! execute "!pdflatex --shell-escape -synctex=1 -interaction=nonstopmode % > /dev/null " | redraw!
autocmd BufWritePost *.tex silent! execute "!latexmk -pdf -silent % > /dev/null" | redraw!
autocmd BufWritePost *.tex silent! execute "!rm -rf *.fls *.ilg *.nav *.snm *.toc *.idx *.lof *.lot *.synctex.gz *.aux *.fdb_latexmk *.fls *.log *.out > /dev/null" | redraw!
autocmd BufWritePost *.tex silent! execute "!pkill -HUP mupdf > /dev/null" | redraw!

" Mutt
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Yaml
autocmd BufRead,BufNewFile *.yaml let g:indentLine_enabled = 1
autocmd BufRead,BufNewFile *.yaml let g:indentLine_char = '⦙'

" Go
autocmd BufRead *.go set noexpandtab
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Conf
au BufNewFile,BufRead *.conf setfiletype conf

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/\.local/share/nvim/*" -not -path "./Library/*" '
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindCurrentWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(expand('<cword>')), 1, <bang>0)
set grepprg=rg\ --vimgrep
