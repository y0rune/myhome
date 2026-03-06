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
let g:python3_host_prog = expand('/opt/homebrew/bin/python3.13')
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
set wrap
set hidden
set cmdheight=1
set encoding=utf-8
set undofile
set scrolloff=8
set termguicolors
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

    " Terraform
    Plug 'hashivim/vim-terraform'

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

    " Prettier
    Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

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
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Tree
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-tree/nvim-tree.lua'

    " SHFMT
    Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

    " Mikrotik
    Plug 'zainin/vim-mikrotik'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'

    " Autopair
    Plug 'windwp/nvim-autopairs'

    " AI
    Plug 'folke/snacks.nvim'
    Plug 'coder/claudecode.nvim'

call plug#end()

" LUA
lua<<EOF
vim.filetype.add({
  -- Ansible
  pattern = {
    [".*playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*roles/.*/.*%.ya?ml"] = "yaml.ansible",
  },
  -- Docker Compose + GitLab CI (merged into one filename table)
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    [".gitlab-ci.yml"] = "yaml.gitlab",
    [".gitlab-ci.yaml"] = "yaml.gitlab",
  },
})

-- capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Prefer LspAttach instead of per-server on_attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, silent = true })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, silent = true })
    vim.keymap.set('n', '<space>K', vim.lsp.buf.hover, { buffer = bufnr, silent = true })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, silent = true })
    vim.keymap.set('n', 'ge', vim.diagnostic.setqflist, { buffer = bufnr, silent = true })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr, silent = true })
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = bufnr, silent = true })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, silent = true })
  end,
})

local border = 'rounded'

vim.lsp.config('*', {
  capabilities = capabilities,
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  },
})

-- Server-specific overrides
vim.lsp.config('yamlls', {
  settings = {
    json = {
      schemas = {
        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"]= "conf/**/*catalog*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://github.com/ansible/schemas/blob/main/f/ansible.json"] = "*.yaml,*.yml",
      }
    },
    yaml = { keyOrdering = false },
  },
})

vim.lsp.config('gopls', {
  cmd = {"gopls", "serve"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
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
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
})

vim.lsp.config('ruff', {})

-- Enable servers (remove 'solargraph' if not using Ruby)
vim.lsp.enable({
  'clangd', 'bashls', 'yamlls', 'ansiblels', 'gopls', 'solargraph',
  'terraformls', 'tflint', 'marksman', 'rust_analyzer', 'ruff',
})

-- nvim-cmp setup with Tab support
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Tab: indent on empty/whitespace-only lines, trigger completion elsewhere
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
        vim.fn.feedkeys(vim.fn["copilot#Accept"](""), "n")
      elseif vim.api.nvim_get_current_line():match("^%s*$") then
        fallback()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),

    -- Shift-Tab: go to previous completion item or fallback
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Enter to confirm selection
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
vim.keymap.set("t", "<C-w>p", "<C-\\><C-n><C-w>p", { desc = "Focus previous window" })

require("claudecode").setup()
EOF

" Added popout window to see diagnostic
set updatetime=250
autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})

" Copilot
let g:copilot_no_tab_map = v:true

" Neoformat
let g:neoformat_try_formatprg = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 1
" autocmd BufWritePre * silent! undojoin | Neoformat

let g:neoformat_python_ruff = {
     \ 'exe': 'ruff',
     \ 'stdin': 1,
     \ 'args': ['format', '--line-length=80', '-q', '-'],
     \ }
let g:neoformat_enabled_python = ['ruff']

" Terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Enable show hidden in NerdTree
let g:NERDTreeShowHidden=1

" latex
let g:tex_flavor = "latex"

" Debug
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]

""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""
" colorscheme gruvbox
" colorscheme default
colorscheme dracula
let g:gruvbox_invert_selection='0'
let g:gruvbox_contrast_dark = 'hard'
set background=dark
" hi Normal ctermbg=NONE
hi Pmenu      ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel   ctermfg=NONE ctermbg=246 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
hi CursorLine cterm=NONE   term=NONE   ctermbg=NONE    guibg=NONE
hi CursorLine ctermbg=235
hi DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
hi DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
hi DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
hi DiffText   cterm=BOLD ctermfg=NONE ctermbg=23
set t_ZH="\e[3m"
set t_ZR="\e[23m"
highlight Comment cterm=italic gui=italic
highlight htmlArg gui=italic cterm=italic

" column
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

" Better tab (visual mode only - insert mode Tab is handled by nvim-cmp above)
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
nnoremap Ó :vertical resize -5<CR>
nnoremap Ô :res -5<CR>
nnoremap ū :res +5<CR>
nnoremap Ł :vertical resize +5<CR>

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

" Better adding into beginning and ending line
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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

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
map <F3> :setlocal spell! spelllang=en<CR>
map <F4> :setlocal spell! spelllang=pl<CR>

" Human Errors
:command! W w
:command! Q q
:command! Wq wq
:command! X x

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
autocmd BufWritePre *.py silent! undojoin | Neoformat ruff
noremap <Leader>f :silent! undojoin \| Neoformat ruff <CR> :w<CR>

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
autocmd BufRead,BufNewFile *.yaml,*.yml let g:indentLine_enabled = 1
autocmd BufRead,BufNewFile *.yaml,*.yml let g:indentLine_char = '⦙'
autocmd BufWritePre *.yaml,*.yml silent! undojoin | Neoformat prettier

" JSON
autocmd BufWritePre *.json silent! undojoin | Neoformat prettier

" GoLang
autocmd BufRead *.go set noexpandtab
autocmd BufWritePre *.go lua go_org_imports()
let g:go_def_mapping_enabled = 0
let g:go#fmt#autosave  = v:true
autocmd BufWritePre *.go silent! undojoin | Neoformat
autocmd BufWritePre *.gomod silent! undojoin | Neoformat

" Conf
au BufNewFile,BufRead *.conf setfiletype conf

" Mikrotik
au BufNewFile,BufRead *.mikrotik setfiletype routeros

" Ebuild
au BufNewFile,BufRead,BufWritePre *.ebuild let g:shfmt_extra_args = '-ci -sr -s'

" TOML
autocmd BufWritePre *.toml silent! undojoin | Neoformat taplo

" Terraform
autocmd BufWritePre *.tf lua vim.lsp.buf.format()
autocmd BufWritePre *.tfvars lua vim.lsp.buf.format()

" Markdown
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd BufWritePre *.md silent! undojoin | Neoformat mdformat

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" highlight the visual selection after pressing enter.
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/\.local/share/nvim/*" -not -path "./Library/*" '
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindCurrentWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(expand('<cword>')), 1, <bang>0)
set grepprg=rg\ --vimgrep

" Custom functions "
function! RemoveForti()
    :%g/set uuid .*/d
    :%g/set comment .*/d
    :%s/  \+//g
    :%s/edit \(\d\{1,}\)/edit 0/g
    :g/^$/d
endfunction

function! RemoveFortiAddresses()
    :e!
    :%g/set uuid .*/d
    :%g/set comment .*/d
    :%s/  \+//g
    :%s/edit \(\d\{1,}\)/edit 0/g
    :%s/next\n/set allow-routing enable\rnext\r/g
    :g/^$/d
    :%!uniq
    :w!
endfunction

function! BlurForti()
    :%g/set uuid .*/d
    :%g/set description .*/d
    :%g/set comment .*/d
    :%g/set comments .*/d
    :%s/username .*/username "XXXXXXXXXXXXXXXXXXXXXXX"/g
    :%s/dn .*/dn "XXXXXXXXXXXXXXXXXXXXXXX"/g
    :%s/psksecret ENC .*/psksecret XXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/password ENC .*/password XXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/passwd ENC .*/passwd XXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/group-name .*/group-name "XXXXXXXXXXXXXXXXXXXXXXX"/g
    :%s/ssh-rsa .*/ssh-rsa XXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/-----BEGIN OPENSSH PRIVATE KEY.*----/-----BEGIN OPENSSH PRIVATE KEY -----\rXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/-----BEGIN CERTIFICATE.*----/-----BEGIN CERTIFICATE -----\rXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/-----BEGIN ENCRYPTED PRIVATE KEY.*----/-----BEGIN ENCRYPTED PRIVATE KEY -----\rXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/g
    :%s/"VPN_.*"/"VPN_XXXXX"/g
    :%s/\v(\d{1,3}\.){3}\d{1,3}/X.X.X.X/g
endfunction

function! ColoursFortiSSL()
    :%s/next\n/set color 23\rset allow-routing enable\rnext\r/g
endfunction
