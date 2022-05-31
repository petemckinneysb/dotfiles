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
Plug 'ajh17/vimcompletesme'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
"node and typescript
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"telescope stuff
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

"treesitter stuff
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

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

let g:coc_global_extensions = ['coc-tsserver' ]

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

"manually run prettier
nnoremap gp :silent %!prettier --stdin-filepath %<CR>

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" nerdtree
let NERDTreeMinimalUI = 1
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true  }, incremental_selection = { enable = true }, textobjects = { enable = true }}

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
nnoremap <leader>K <cmd>Telescope grep_string<cr>

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


" Copy current buffer file path
" Fixme
" nnoremap <leader>yy :call CopyPath(0)<CR>

" Fixme
" Copy current buffer directory
" nnoremap <leader>yd :call CopyPath(1)<CR>


" RG
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
nnoremap \ :Rg<SPACE>
nnoremap <Leader>ps :Rg<SPACE>
