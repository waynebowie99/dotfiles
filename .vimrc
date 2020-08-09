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
        "au GUIEnter * simalt ~x
    endif
" }

""" Plugins: {
    call plug#begin()

    """ Themeing
    " Airline: {
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        let g:airline_detect_modified = 1
        let g:airline_powerline_fonts = 1

        let g:airline#extensions#wordcount#enabled = 1
        let g:airline#extensions#whitespace#enabled = 1
        let g:airline#extensions#bookmark#enabled = 1
        let g:airline#extensions#coc#enabled = 1
        let g:airline#extensions#csv#enabled = 1
        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#dirvish#enabled = 1
        let g:airline#extensions#fugitiveline#enable = 1
        let g:airline#extensions#gutentags#enabled = 1
        let g:airline#extensions#term#enable = 1

    " }

    """ Syntax/Formatting
    " Completion: {
        Plug 'lifepillar/vim-mucomplete'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        let g:mucomplete#no_mappings = 0
        let g:mucomplete#enable_auto_at_startup = 1
        let g:mucomplete#completion_delay = 1

        let g:coc_global_extensions=['coc-vimlsp', 'coc-restclient', 'coc-lists', 'coc-powershell', 'coc-json', 'coc-yank', 'coc-snippets', 'coc-marketplace', 'coc-highlight']

        " inoremap <silent><expr> <TAB>
        "             \ pumvisible() ? \"\<C-n>" :
        "             \ <SID>check_back_space() ? \"\<TAB>" :
        "             \ coc#refresh()
        " inoremap <expr><S-TAB> pumvisible() ? \"\<C-p>" : \"\<C-h>"

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        if has("patch-8.1.1564")
            " Recently vim can merge signcolumn and number column into one
            set signcolumn=number
        else
            set signcolumn=yes
        endif

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Remap keys for gotos
        "nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> <leader>cgy <Plug>(coc-type-definition)
        nmap <silent> <leader>cgi <Plug>(coc-implementation)
        nmap <silent> <leader>cgr <Plug>(coc-references)

        autocmd CursorHold * silent call CocActionAsync('highlight')
        nmap <leader>rn <Plug>(coc-rename)
        nmap <leader>ca  <Plug>(coc-codeaction)
        nnoremap <silent> <leader>a  :CocList diagnostics<cr>
        nnoremap <silent> <leader>aj <Plug>(coc-diagnostic-next)
        nnoremap <silent> <leader>ak <Plug>(coc-diagnostic-prev)

        nnoremap <leader>cl :CocList<CR>
        nnoremap <leader>cr :CocRestart<CR>
        nnoremap <leader>cn :CocNext<CR>
        nnoremap <leader>cp :CocPrev<CR>
    " }
    " Lang Server:{
        Plug 'OmniSharp/Omnisharp-vim'
        let g:OmniSharp_server_stdio = 0

        if has('patch-8.1.1880')
            set completeopt=longest,menuone,popuphidden
            " Highlight the completion documentation popup background/foreground the same as
            " the completion menu itself, for better readability with highlighted
            " documentation.
            set completepopup=highlight:Pmenu,border:off
        else
            set completeopt=longest,menuone,preview
            " Set desired preview window height for viewing documentation.
            set previewheight=5
        endif

        augroup omnisharp_commands
            autocmd!

            " Show type information automatically when the cursor stops moving.
            " Note that the type is echoed to the Vim command line, and will overwrite
            " any other messages in this space including e.g. ALE linting messages.
            autocmd CursorHold *.cs OmniSharpTypeLookup

            " The following commands are contextual, based on the cursor position.
            autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
            autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
            autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
            autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
            autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
            autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

            " Navigate up and down by method/property/field
            autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
            autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
            " Find all code errors/warnings for the current solution and populate the quickfix window
            autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
            " Contextual code actions (uses fzf, CtrlP or unite.vim when available)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
            autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)

            autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

            autocmd FileType cs nmap <silent> <buffer> <Leader>osrn <Plug>(omnisharp_rename)

            autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
            autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
        augroup END
    " }
    " Make and Test: {
        Plug 'puremourning/vimspector'
        Plug 'janko-m/vim-test'
        Plug 'skywind3000/asyncrun.vim'
        Plug 'skywind3000/asynctasks.vim'

        let g:asyncrun_open = 6

        let test#strategy = 'asyncrun_background_term'
        let test#csharp#runner = 'dotnettest'
        nmap <silent> <leader>tn :TestNearest<CR>
        nmap <silent> <leader>tf :TestFile<CR>
        nmap <silent> <leader>ts :TestSuite<CR>
        nmap <silent> <leader>tl :TestLast<CR>
        nmap <silent> <leader>tg :TestVisit<CR>

        nmap <leader>vss <Plug>VimspectorStop
        nmap <leader>vsc <Plug>VimspectorContinue
        nmap <leader>vsp <Plug>VimspectorPause
        nmap <leader>vsr <Plug>VimspectorRestart
        nmap <leader>vsb <Plug>VimspectorToggleBreakpoint
        nmap <leader>vsso <Plug>VimspectorStepOver
        nmap <leader>vssi <Plug>VimspectorStepInto
        nmap <leader>vssu <Plug>VimspectorStepOut
        nmap <leader>vsw :VimspectorWatch 
        nmap <leader>vse :VimspectorEval 
        nmap <leader>vso :VimspectorShowOutput 
        nnoremap <leader>vsd :call Vimspector_Reset()<CR>
        function! Vimspector_Reset()
            call vimspector#Reset()
            if has('win32')
                silent !taskkill.exe /IM dotnet.exe /F
            end
        endfunction
    " }
    " Git: {
        Plug 'airblade/vim-gitgutter'
        Plug 'tpope/vim-fugitive'
        Plug 'ludovicchabant/vim-gutentags'

        nnoremap <leader>gb :Gblame<CR>
        nnoremap <leader>gl :Glog<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gg :G<CR>

        nnoremap <leader>dg :diffget<CR>
    " }
    " File Management: {
        Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
        Plug 'liuchengxu/vista.vim'
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

        nnoremap <leader>e :Clap filer<CR>
        nnoremap <leader>f :Clap files<CR>
        nnoremap <leader>t :Clap proj_tags<CR>
        nnoremap <leader>T :Clap tags<CR>
        nnoremap <leader>b :Clap buffers<CR>
        nnoremap <leader>/ :Clap grep2<CR>
        nnoremap <leader>h :Clap help_tags<CR>
        nnoremap <leader>m :Clap marks<CR>
        nnoremap <leader>y :Clap yanks<CR>
    "}
    " Movement: {
        Plug 'justinmk/vim-sneak'
        Plug 'kshenoy/vim-signature'
        let g:sneak#use_ic_scs = 1
        map f <Plug>Sneak_f
        map F <Plug>Sneak_F
        map t <Plug>Sneak_t
        map T <Plug>Sneak_T
    "}
    " Tpope: {
        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-dispatch'
        Plug 'tpope/vim-unimpaired'
        Plug 'tpope/vim-eunuch'
        Plug 'tpope/vim-repeat'
        Plug 'tpope/vim-dotenv'
    " }
    " Database: {
        Plug 'tpope/vim-dadbod'
        Plug 'kristijanhusak/vim-dadbod-ui'
    " }
    " Syntax: {
        Plug 'sheerun/vim-polyglot'
        Plug 'kevinoid/vim-jsonc'
        Plug 'chrisbra/csv.vim'
        Plug 'yggdroot/indentline'
        au BufRead,BufNewFile *.xaml setfiletype xml
    " }
    " Formatting: {
        Plug 'tomtom/tcomment_vim'
    " }
    " Style: {
        Plug 'morhetz/gruvbox'
    " }

    """ Buffer Manangement
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
    " Themeing: {
        " Must be loaded after other plugins to be usable
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

""" Functions: {
"}

""" AutoCMD: {
"}

""" Commands: {
    ":R [command]
    :command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
    ":Format
    command! -nargs=0 Format :call CocAction('format')
"}

""" Mappings: {
    nnoremap , za 
    nnoremap <C-W>\ <C-W>\| <C-W>_
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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
    set ttymouse=
    set autoindent
    set copyindent
    set backspace=indent,eol,start
    set smartcase
    set ignorecase
    set ruler
    set nu
    set rnu
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
    colorscheme gruvbox
    set background=dark
    set nohls
    set hidden
    "set cmdheight=2
    "set updatetime=300
    "set shortmess+=c
    set lazyredraw
    set autoread
    "set linebreak
    "set wildmenu
    set foldmethod=indent
    set nofoldenable
    set backup
    set writebackup
    set backupdir=.backup/,~/.backup/,/tmp//
    set directory=.swp/,~/.swp/,/tmp//
    set undofile
    set undodir=.undo/,~/.undo/,/tmp//
" }
