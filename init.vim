if &compatible
  set nocompatible
endif 

set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')
  " Add or remove you plugins here: " 
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim') 
  call dein#add('autozimu/LanguageClient-neovim', {
      \ 'rev': 'next',
      \ 'build': 'bash install.sh',
      \ })
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('kassio/neoterm')
  call dein#add('lervag/vimtex')
  call dein#add('SirVer/ultisnips')
  call dein#add('tpope/vim-surround')
  call dein#add('scrooloose/nerdtree')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('tpope/vim-commentary')
  call dein#add('michaeljsmith/vim-indent-object')
  
  " markdown stuff
  call dein#add('ferrine/md-img-paste.vim')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'cd app & yarn install' })
  " Colorschemes
  call dein#add('dylanaraps/wal.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('jacoborus/tender.vim')
  call dein#add('mhartington/oceanic-next')
  call dein#add('liuchengxu/space-vim-dark')
  call dein#add('joshdick/onedark.vim')
  call dein#add('tomasr/molokai')
  call dein#add('dikiaap/minimalist')
  call dein#add('cseelus/vim-colors-lucid')
  call dein#add('YorickPeterse/happy_hacking.vim')

  " Appearance plugins
  call dein#add('junegunn/goyo.vim')
  call dein#add('itchyny/lightline.vim')

  call dein#end()
  call dein#save_state()
endif


" basics
filetype plugin indent on
set shiftwidth=2
set colorcolumn=81  " 80 is the limit
set expandtab
set smartindent
set ignorecase
set smartcase
syntax enable
syntax on
set number "absolute line numbers
" set scrollbind "scroll splits at the same time. For file comparing
" set scb & set noscb  "this are the commands to turn on and off the scrollbinding
set ruler
set incsearch
set nohlsearch
set mouse=a " allows to use the mouse. Useful to resize window splits.
" terminal
set shell=bash
tnoremap <C-[> <C-\><C-n>


" filetype dependent identation
autocmd FileType c setlocal shiftwidth=8 softtabstop=8 expandtab


" markdown create image from clipboard
autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'


" Colorscheme / colors
" [wal, OceanicNext, space-vim-dark, tender, onedark, molokai, minimalist,
" lucid, happy_hacking]
let mi_colorscheme = "happy_hacking"
" let g:lightline = {'colorscheme': 'one'}
if mi_colorscheme != "wal"
  execute 'color' mi_colorscheme
  set termguicolors
  " hi StatusLine ctermbg=NONE cterm=NONE  "transparent status line
  hi LineNr ctermbg=NONE guibg=NONE
else
  execute 'color' mi_colorscheme
endif


" fold settings
set foldmethod=indent  "fold automatically generated by identation rules
set foldnestmax=10
set nofoldenable "makes sure that when opening, files are "normal", i.e. not folded
set foldlevel=2


" mappings
map <C-n> :NERDTreeToggle<CR>


" vimtext
" let g:vimtex_view_method = 'zathura'
" let g:vimtex_quickfix_mode=0
" let g:vimtex_compiler_latexmk = {
"         \ 'backend' : 'nvim',
"         \ 'background' : 1,
"         \ 'build_dir' : '',
"         \ 'callback' : 1,
"         \ 'continuous' : 1,
"         \ 'executable' : 'latexmk',
"         \ 'options' : [
"         \   '-pdf',
"         \   '-verbose',
"         \   '-file-line-error',
"         \   '-synctex=1',
"         \   '-interaction=nonstopmode',
"         \   '--shell-escape',
"         \ ],
"         \}


" ULtiSnips
let g:UltiSnipsSnippetsDir = "~/.config/nvim/snippets_ulti"
let g:UltiSnipsSnippetDirectories=["snippets_ulti"]
let g:UltiSnipsEditSplit = "vertical"
map gs :UltiSnipsEdit <CR>


" Language Server Protocol (LSP) with LanguageClient-neovim plugin
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
      \ 'python': ['/home/luis/anaconda3/bin/pyls'],
      \ 'cpp': ['/usr/bin/clangd-7'],
      \ 'c': ['/usr/bin/clangd-7'],
      \ }
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" Autocompletion Configurations
let g:deoplete#enable_at_startup = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" One key compilation and execution
" Note: % is the current buffer filename. %:r is the buffer filename without extension 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
" autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
" autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>


""""""""""""
" Neoterm
""""""""""""
" Building
autocmd filetype c nnoremap <F7> :T make<CR>
autocmd filetype c nnoremap <F8> :T make run<CR>
autocmd filetype cpp nnoremap <F7> :T make<CR>
nnoremap <C-L> :Tclear<CR>

" REPL shortcuts
nnoremap <Leader>2 :TREPLSendLine<CR>
vnoremap <Leader>2 :TREPLSendSelection<CR>

" Other
let g:neoterm_autoscroll = '1' "autoscroll terminal output
let g:neoterm_size = 10        "default would take 50% of neovim window


"""""""""""""
" Control P
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
"""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <leader>b :CtrlPBuffer<CR>
