set nocompatible              " be iMproved, required
set exrc
set noswapfile
set nobackup
set encoding=utf-8
set clipboard=unnamedplus
set incsearch
set noshowmode
set relativenumber
set ic

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax enable
filetype plugin indent on

call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'morhetz/gruvbox'
    Plug 'vim-utils/vim-man'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    Plug 'jiangmiao/auto-pairs'
    Plug 'airblade/vim-gitgutter'

    "node and typescript
    Plug 'sbdchd/neoformat'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    "telescope stuff
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    "treesitter stuff
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'mfussenegger/nvim-dap'
    Plug 'nvim-telescope/telescope-dap.nvim'
call plug#end()
let g:neoformat_try_node_exe = 1
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.ts Neoformat
autocmd BufWritePre *.html Neoformat
autocmd BufWritePre *.scss Neoformat

set completeopt=menu,menuone,noselect


lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['angularls'].setup {
    capabilities = capabilities
  }
EOF

autocmd vimenter * ++nested colorscheme gruvbox
set termguicolors
set noerrorbells
set vb t_vb=
set background=dark
set undodir=~/.vim/undodir
set undofile
set tabstop=4
set shiftwidth=4
set expandtab
set nu
set nowrap
set scrolloff=8

autocmd BufWritePre * %s/\s\+$//e
autocmd VimResized * wincmd =
set equalalways

set hidden

let mapleader= " "

"macros
let g:gitgutter_map_keys = 0

" nerdtree
let NERDTreeMinimalUI = 1
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true  }, incremental_selection = { enable = true }, textobjects = { enable = true }}

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH    <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gA    <cmd>lua vim.lsp.buf.code_action()<cr>


"   " For simple sizing of splits.
map - <C-W>-
map + <C-W>+

nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>
nmap <leader>u :UndotreeShow<CR>
nmap <silent>; :
nmap <leader>pf :CtrlP<CR>
nnoremap <Leader>pt :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>pv :NERDTreeFind<CR>
nnoremap <silent> <Leader>vr :vertical resize 30<CR>
nnoremap <silent> <Leader>r+ :vertical resize +5<CR>
nnoremap <silent> <Leader>r- :vertical resize -5<CR>
noremap <leader>\ :!npm run start<return>
noremap <leader>{ f{V%
nmap <leader><leader> ^
vmap <Leader>y "+y
vmap <Leader>= <C-W><C-=>
nnoremap <leader>ga <cmd>Git blame<cr>

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)


" telescope
" Find files using telescope command line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gt <cmd>Telescope git_stash<cr>
nnoremap <leader>gbr <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gbc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fk <cmd>Telescope grep_string<cr>

"lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>


nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>gt <cmd>lua require('telescope.builtin').git_stash()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gbc <cmd>lua require('telescope.builtin').git_bcommits()<cr>

nnoremap <leader>K <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>r <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>sh <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>ch <cmd>lua require('telescope.builtin').command_history()<cr>

map œ <M-q>

lua << EOF
local dap = require('dap')
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/.debug/vscode-node-debug2/out/src/nodeDebug.js'}
    }
EOF
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <S-k> :lua require'dap'.step_out()<CR>
nnoremap <S-l> :lua require'dap'.step_into()<CR>
nnoremap <S-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>ds :lua require'dap'.stop()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover()<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
"nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
"nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
"nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
"nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>

" Plug 'nvim-telescope/telescope-dap.nvim'
lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF
nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>dc :Telescope dap commands<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>


" Copy current buffer file path
" Fixme
" nnoremap <leader>yy :call CopyPath(0)<CR>

" Fixme
" Copy current buffer directory
" nnoremap <leader>yd :call CopyPath(1)<CR>


" RG
" bind K to grep word under cursor
"nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
"command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
"nnoremap \ :Rg<SPACE>
"nnoremap <Leader>ps :Rg<SPACE>
