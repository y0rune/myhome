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

    " Live-preview
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

    " Copilot
    Plug 'github/copilot.vim'

    " PyRight
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

    " Ansible yaml
    Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
    Plug 'Yggdroot/indentLine'

    " Multiple cursors
    Plug 'terryma/vim-multiple-cursors'

    " Enable gentoo-syntax in vim
    Plug 'gentoo/gentoo-syntax'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'

    " Git tool
    Plug 'tpope/vim-fugitive'

    " Prettier
    Plug 'prettier/vim-prettier'

    " Debug
    Plug 'puremourning/vimspector'
    Plug 'mfussenegger/nvim-dap'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'sbdchd/neoformat'

    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/nvim-vsnip'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Tree
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-tree/nvim-tree.lua'

    Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
    Plug 'zainin/vim-mikrotik'
call plug#end()

" LUA
lua<<EOF
local opts = { noremap=true, silent=true }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'bashls', 'yamlls', 'ansiblels', 'gopls', 'solargraph', 'terraformls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    handlers=handlers,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Handlers when you are in the insert mode you see the errors
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {update_in_insert = true})

-- Setup a yamlls plugin
require'lspconfig'.yamlls.setup{
  settings = {
    json = {
        schemas = {
            ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"]= "conf/**/*catalog*",
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://github.com/ansible/schemas/blob/main/f/ansible.json"] = "*.yaml,*.yml"
        }
    },
  }
}

-- Setup GoLang
require'lspconfig'.gopls.setup {
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    on_attach = on_attach,
    handlers=handlers,
    capabilities = capabilities,
    settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			linksInHover = false,
			codelenses = {
				generate = true,
				gc_details = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_depdendency = true,
				vendor = true,
			},
			usePlaceholders = true,
		},
    },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-a>'] = cmp.mapping.scroll_docs(-4),
    ['<C-s>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'vsnip' },
    { name = 'ultisnips' },
    { name = 'snippy' },
    { name = 'path' },
    { name = 'buffer' }
  },
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({

    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.cmdline('/', {

  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

require("nvim-tree").setup({
})

EOF

" Added popout window to see diagnostic
set updatetime=250
autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})

" Neoformat
let g:neoformat_try_formatprg = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 1
autocmd BufWritePre * silent! undojoin | Neoformat prettier
let g:neoformat_python_black = {
    \ 'exe': 'black',
    \ 'stdin': 1,
    \ 'args': ['--line-length', '80', '-q', '-'],
    \ }
let g:neoformat_enabled_python = ['black']


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
"colorscheme default
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

set statusline=
set statusline+=%#IncSearch#
set statusline+=%{&filetype!=#''?'\ \ ['.&filetype.']\ ':'\ '}
set statusline+=%{&modified?'[+]\ ':''}
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
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
nmap <leader>2 :w!<cr>

" Adding print message
autocmd FileType python nmap <leader>f i print("--------DEBUG--------")<CR>print()<CR>print("--------END DEBUG--------")<UP><LEFT>
autocmd FileType sh nmap <leader>f i echo -e "--------DEBUG--------"<CR>echo -e ""<CR>echo -e "--------END DEBUG--------"<UP><LEFT>

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

" Better word
nmap yw vey

" Select all text
nmap <C-a> gg<S-v>G

" Telescope
nmap <Leader>e <cmd>Telescope buffers<cr>
nmap <Leader>w <cmd>Telescope find_files<cr>
nmap <Leader>q <cmd>Telescope live_grep<cr>
nmap <Leader>g <cmd>Telescope git_branches<cr>
nmap <Leader>a <cmd>Telescope diagnostics<cr>

" Resize window
nnoremap <C-L> :vertical resize +5<CR>
nnoremap <C-H> :vertical resize -5<CR>
nnoremap <C-J> :res -5<CR>
nnoremap <C-K> :res +5<CR>

" Split window
nnoremap _ :vsp <CR>
nnoremap - :split <CR>

" Reload file
nnoremap <F5> :edit <CR>
nnoremap <Leader><F5> :edit! <CR>

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Moving line up or down using alt
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
nnoremap <C-t> :tabnew<CR>

nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>
inoremap <F7>  <Esc>:tabprevious<CR>i
inoremap <F8>  <Esc>:tabnext<CR>i

nnoremap <Leader>k :tabprevious<CR>
nnoremap <Leader>j :tabnext<CR>

inoremap <C-t> <Esc>:tabnew<CR>

" Better moving
nnoremap J }
nnoremap K {
vnoremap J }
vnoremap K {

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
map <C-d> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
nnoremap <F11> :Goyo <CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
map <F3> :setlocal spell! spelllang=en_gb<CR>
map <F4> :setlocal spell! spelllang=pl<CR>

" Human Errors
:command! W w
:command! Q q
:command! Wq wq

""""""""""""""""""""""""""""""""
" Custom functions
""""""""""""""""""""""""""""""""
lua <<EOF
  function go_org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end
EOF


""""""""""""""""""""""""""""""""
" Files
""""""""""""""""""""""""""""""""


" Bash
if executable('shfmt')
  let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
endif

let g:shfmt_extra_args = '-i 4 -ci -sr -s'
let g:shfmt_fmt_on_save = 1
let g:shfmt_opt="-ci"

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
au BufRead,BufNewFile *.yaml,*.yml if search('hosts:\|tasks:', 'nw') | set ft=yaml.ansible | endif

" Go
autocmd BufRead *.go set noexpandtab
autocmd BufWritePre *.go lua go_org_imports()

" Conf
au BufNewFile,BufRead *.conf setfiletype conf

" Mikrotik
au BufNewFile,BufRead *.mikrotik setfiletype routeros

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Source: https://vi.stackexchange.com/questions/20077/automatically-highlight-all-occurrences-of-the-selected-text-in-visual-mode
" highlight the visual selection after pressing enter.
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/\.local/share/nvim/*" -not -path "./Library/*" '
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindCurrentWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(expand('<cword>')), 1, <bang>0)
set grepprg=rg\ --vimgrep
