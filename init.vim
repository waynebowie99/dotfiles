"Space as learder
let mapleader=" "

set nocompatible
filetype plugin indent on

"Plugins
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Themeing
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rstacruz/vim-closer'

Plug 'junegunn/fzf'

" Syntax
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoyank.vim'
Plug 'w0rp/ale'
Plug 'harenome/vim-mipssyntax'
Plug 'andymass/vim-matlab', {'for': 'matlab'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'OmniSharp/csharp-language-server-protocol'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'future',
            \ 'do': 'bash install.sh',
            \ }

" Window management
Plug 'wesQ3/vim-windowswap'
Plug 'simeji/winresizer'
Plug 'mhinz/vim-startify'
Plug 'dhruvasagar/vim-zoom'

" Movement
" Plug 'justinmk/vim-sneak'

" Ease of Use
Plug 'drmikehenry/vim-fontsize'

Plug 'sbdchd/neoformat'
Plug 'artur-shaik/vim-javacomplete2', {'for': 'java'}
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified=1
let g:airline_detect_spell=1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
set laststatus=2

"NERD Tree
nmap <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Tabular
nmap <leader>a= :Tab /=<CR>
vmap <leader>a= :Tab /=<CR>
nmap <leader>a: :Tab /:\zs<CR>
vmap <leader>a: :Tab /:\zs<CR>
nmap <leader>a<space> :Tab /
vmap <leader>a<space> :Tab /
nmap <leader>a/ :%Tab /\/\/<CR>
vmap <leader>a/ :Tab /\/\/<CR>

" Ale
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
"let g:ale_java_javac_classpath = '~/Programming/Java/'
let g:ale_fixers = {
            \   'java':['google_java_format', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace'],
            \   'json':['prettier', 'remove_trailing_lines', 'trim_whitespace'],
            \   '': ['uncrustify', 'prettier', 'remove_trailing_lines', 'trim_whitespace']
            \}

" OmniSharp
augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " Update the highlighting whenever leaving insert mode
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

    " Alternatively, use a mapping to refresh highlighting for the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Language Server
nnoremap <F6> :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_serverCommands = {
            \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
            \ 'cs': ['/home/wayne/.omnisharp/omnisharp-roslyn/run', 'lsp'],
            \ 'python': ['pyls'],
            \ }
function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    endif
endfunction

autocmd FileType * call LC_maps()

"Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
inoremap <S-Tab> <C-V><Tab>
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
let g:neosnippet#enable_snipmate_compatibility = 1

" Ctrl-b to open Tagbar
map <C-b> :TagbarToggle<CR>

" Denite
nnoremap <leader>: :Denite command<CR>
nnoremap <leader>" :Denite register<CR>
nnoremap <leader>b :Denite buffer:!<CR>
nnoremap <leader>K :DeniteCursorWord help<CR>
nnoremap <leader>R :Denite file_mru<CR>
nnoremap <leader>Y :DeniteCursorWord neoyank<CR>
nnoremap <leader>y :Denite neoyank<CR>
nnoremap <C-p> :Denite file_rec<CR>
nnoremap <leader>/ :Denite grep:.<CR>
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

"Window Movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"Basic Remapping
inoremap jk <ESC>
inoremap kj <ESC>
nmap <leader>s :w!<CR>
nmap <leader>q :q!<CR>
nmap , za
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" Function key remaps
" Fix tab
nnoremap <silent> <F3> mzgg=G`z
" Run makefile
nnoremap <silent> <F4> :make<CR>
" Reload file
nnoremap <silent> <F5> :e %<CR>

"General
set backupdir=~/.config/nvim/backup,.
set directory=~/.config/nvim/backup,.

"Styling
syntax on
set autoindent
set copyindent
set backspace=indent,eol,start
set ignorecase
set smartcase
set ruler
set nu!
set rnu!
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set background=dark
colorscheme desert
set guifont=Hack
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set ignorecase
set nohlsearch
set foldmethod=indent
