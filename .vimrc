"Space as learder
let mapleader=" "

set nocompatible
filetype plugin indent on

""" Init Config: {
    if has("unix")
        if has("nvim")
            if empty(glob('~/.config/nvim/autoload/plug.vim'))
                silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                autocmd VimEnter * PlugInstall --sync
                source $MYVIMRC
            endif
        else
        end
    else
        let g:python3_host_prog='C:\Python38\python.exe'
        let $HOME = $USERPROFILE
    end

    if has("gui_running")
        set guioptions=i
        set guifont=FantasqueSansMono_Nerd_Font_Mon:h12
        au GUIEnter * simalt ~x
    endif
" }

""" Plugins: {
    call plug#begin()

    """ Themeing
    " Airline: {
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        let g:airline_detect_modified= 1
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#wordcount#enabled = 1
        let g:airline#extensions#whitespace#enabled = 1

        let g:airline#extensions#coc#enabled = 1

        let g:airline#extensions#tabline#buffer_nr_show = 0
        let g:airline#extensions#tabline#formatter = 'unique_tail'

        let g:airline#extensions#neomake#enabled = 1
    " }

    """ Syntax/Formatting
    " Auto Complete: {
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-powershell', 'coc-json', 'coc-yank', 'coc-snippets', 'coc-marketplace', 'coc-highlight', 'coc-git', 'coc-python' ]

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        autocmd CursorHold * silent call CocActionAsync('highlight')
        nmap <leader>rn <Plug>(coc-rename)
        nmap <leader>ac  <Plug>(coc-codeaction)
        nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
        nnoremap <silent> <leader>aj <Plug>(coc-diagnostic-next)
        nnoremap <silent> <leader>ak <Plug>(coc-diagnostic-prev)
        nnoremap <leader>cr :CocRestart<CR>
    " }
    " Make and Test: {
        Plug 'janko-m/vim-test'
        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-dispatch'

        let test#strategy = "dispatch"
        nmap <silent> <leader>tn :TestNearest<CR>
        nmap <silent> <leader>tf :TestFile<CR>
        nmap <silent> <leader>ts :TestSuite<CR>
        nmap <silent> <leader>tl :TestLast<CR>
        nmap <silent> <leader>tg :TestVisit<CR>
        let test#csharp#runner = 'dotnettest'
    " }
    " Git: {
        Plug 'tpope/vim-fugitive'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'airblade/vim-gitgutter'

        let g:gitgutter_override_sign_column_highlight = 1

        nnoremap <leader>gb :Gblame<CR>
        nnoremap <leader>gl :Glog<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gg :G<CR>
    " }
    " Network: {
        Plug 'tpope/vim-dadbod'
        Plug 'diepm/vim-rest-console'
    " }
    " Syntax: {
        Plug 'sheerun/vim-polyglot'
        Plug 'chrisbra/csv.vim'
        au BufRead,BufNewFile *.xaml setfiletype xml
    " }
    " Formatting: {
        Plug 'tpope/vim-endwise'
        Plug 'preservim/nerdcommenter'
    " }
    " Style: {
        Plug 'morhetz/gruvbox'
    " }

    """ Buffer Manangement
    " File Management: {
        " Required Universal ctags
        Plug 'liuchengxu/vim-clap'
        Plug 'liuchengxu/vista.vim'
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'vifm/vifm.vim'

        nnoremap <leader>v :Vifm<CR>
        nnoremap <leader>" :Clap registers<CR>

        nnoremap <leader>/ :Clap grep<CR>

        nnoremap <leader>F :Clap filer<CR>
        nnoremap <leader>f :Clap files<CR>
        nnoremap <leader>h :Clap history<CR>
        nnoremap <leader>b :Clap buffers<CR>
        nnoremap <leader>l :Clap lines<CR>

        nnoremap <leader>t :Clap tags<CR>
        nnoremap <leader>tt :Clap proj_tags<CR>
    " }
    " Working Directory: {
        Plug 'airblade/vim-rooter'

        let g:rooter_patterns = ['*.sln', '.projections.json', 'makefile', '.git', '.git/']
        let g:rooter_change_directory_for_non_project_files = 'current'
    " }
    " Start Menu: {
        Plug 'mhinz/vim-startify'
        nnoremap <leader>sm :Startify<CR>
        nnoremap <leader>sc :SClose<CR>
        nnoremap <leader>ss :SSave<CR>
        nnoremap <leader>sl :SLoad<CR>
    " }
    " Timing Startup: {
        Plug 'tweekmonster/startuptime.vim'
    " }
    " Themeing: {
        Plug 'ryanoasis/vim-devicons'
    " }

    call plug#end()
" }

""" Window Movement: {
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    set splitbelow
    set splitright
" }

""" Function key remaps: {
    " Fix tab
    nnoremap <silent> <F3> mzgg=G`zzz
    " Run makefile
    nnoremap <silent> <F5> :make<CR>
" }

""" Commands: {
    ":R [command]
    :command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
"}

""" General: {
    nnoremap , zA
    nnoremap <leader>qc :cclose<CR>
    nnoremap <leader>qo :copen<CR>
    nnoremap <leader>qj :cnext<CR>
    nnoremap <leader>qk :cprevious<CR>
    nnoremap <leader>qn :cnext<CR>
    nnoremap <leader>qp :cprevious<CR>

    nnoremap <C-W>\ <C-W>\| <C-W>_

    if has("win32")
        nnoremap <leader>mt :term powershell<CR>
    else
        nnoremap <leader>mt :term<CR>
    endif
" }

""" Styling: {
    syntax on
    set encoding=utf8
    set mouse=
    set autoindent
    set copyindent
    set backspace=indent,eol,start
    set ignorecase
    set smartcase
    set ruler
    set nu
    set rnu
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
    colorscheme gruvbox
    set nohlsearch
    set hidden
    set nobackup
    set nowritebackup
    set noswapfile
    set cmdheight=2
    set updatetime=300
    set shortmess+=c
    set lazyredraw
    set autoread
    set linebreak
    set wildmenu
    set foldmethod=indent
    set nofoldenable
" }
