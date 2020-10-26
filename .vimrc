"Space as learder
let mapleader=" "

""" Init Config: {
    if has("unix")
        let g:dotvim = '~/.vim/'
    else
        let g:dotvim = '~/vimfiles/'
    endif

    if empty(glob(g:dotvim . '/autoload/plug.vim'))
        silent execute '!curl -fLo ' . g:dotvim . '/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    if has("gui_running")
        set guioptions=i
        set guifont=FantasqueSansMono_Nerd_Font_Mon:h12
    endif
" }

""" Plugins: {
    call plug#begin()

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'puremourning/vimspector'
    Plug 'janko-m/vim-test'
    Plug 'skywind3000/asyncrun.vim' | Plug 'skywind3000/asynctasks.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'tpope/vim-vinegar'
    Plug 'liuchengxu/vim-clap', { 'do': ':call clap#installer#download_binary()' } | Plug 'liuchengxu/vista.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'tpope/vim-projectionist'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-eunuch'
    Plug 'sheerun/vim-polyglot'
    Plug 'sirtaj/vim-openscad'
    Plug 'kevinoid/vim-jsonc'
    Plug 'yggdroot/indentline'
    Plug 'jiangmiao/auto-pairs'
    Plug 'SirVer/ultisnips'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'OmniSharp/Omnisharp-vim', { 'for': 'cs' }
    Plug 'justinmk/vim-sneak'
    Plug 'mbbill/undotree'
    Plug 'tomtom/tcomment_vim'
    Plug 'airblade/vim-rooter'
    Plug 'morhetz/gruvbox'
    Plug 'mhinz/vim-startify'

    " Must be loaded after other plugins to be usable
    Plug 'ryanoasis/vim-devicons'

    call plug#end()
" }

""" Plugin Config: {
    """ Airline: {
        let g:airline_detect_modified = 1
        let g:airline_powerline_fonts = 1

        let g:airline_section_c = '%F'

        let g:airline#extensions#wordcount#enabled = 1
        let g:airline#extensions#whitespace#enabled = 1
        let g:airline#extensions#bookmark#enabled = 1
        let g:airline#extensions#csv#enabled = 1
        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#fugitiveline#enable = 1
        let g:airline#extensions#gutentags#enabled = 1
        let g:airline#extensions#term#enable = 1
        let g:airline#extensions#coc#enabled = 1
    "}

    """ AsyncTask: {
        let g:asyncrun_open = 0

        function BuildRun()
            :AsyncStop
            :AsyncTask build
            while g:asyncrun_status == 'running'
                sleep 50m
            endwhile
            :AsyncTask run
        endfunction

        function! RefreshUI()
            if exists(':AirlineRefresh')
                AirlineRefresh
            else
                " Clear & redraw the screen, then redraw all statuslines.
                redraw!
                redrawstatus!
            endif
        endfunction

        let g:asyncrun_exit = 'call RefreshUI()'
        autocmd VimEnter * let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

        nnoremap <silent> <leader>br :call job_start(BuildRun())<CR>
        nnoremap <silent> <leader>as :AsyncStop<CR>
        nnoremap <silent> <leader>ar :AsyncTask run<CR>
        nnoremap <silent> <leader>ab :AsyncTask build<CR>
    "}
    "
    " Coc: {
        let g:coc_global_extensions=['coc-omnisharp', 'coc-tsserver', 'coc-python', 'coc-tasks', 'coc-html', 'coc-vimlsp', 'coc-restclient', 'coc-lists', 'coc-powershell', 'coc-json', 'coc-yank', 'coc-snippets', 'coc-marketplace', 'coc-highlight']

        inoremap <silent><expr> <c-space> coc#refresh()

        nmap <silent> <leader>cgi <Plug>(coc-implementation)
        nmap <silent> <leader>cgr <Plug>(coc-references)
        nmap <silent> <leader>cgd <Plug>(coc-declaration)
        nnoremap <leader>cfm <Plug>(coc-format)
        nnoremap <leader>cqf <Plug>(coc-fix-current)
        nnoremap <leader>cca <Plug>(coc-codelens-action)
        nnoremap <leader>crf <Plug>(coc-refactor)

        autocmd CursorHold * silent call CocActionAsync('highlight')
        nmap <leader>crn <Plug>(coc-rename)
        nnoremap <leader>ca :CocAction<CR>
        vnoremap <leader>ca :CocAction<CR>
        nnoremap <silent> <leader>cd :CocList diagnostics<CR>

        nnoremap <leader>cs :CocSearch -SLwe 
        nnoremap <leader>cl :CocList<CR>
        nnoremap <leader>at :CocList tasks<CR>
        nnoremap <leader>cr :CocRestart<CR>
        nnoremap <leader>cn :CocNext<CR>
        nnoremap <leader>cp :CocPrev<CR>
    " }

    """ Startify: {
        nnoremap <leader>sm :Startify<CR>
        nnoremap <leader>sc :SClose<CR>
        nnoremap <leader>ss :SSave!<CR>
        nnoremap <leader>sl :SLoad<CR>

        let g:startify_skiplist= ['\\192.168.167*', '\\192.168.165*']
    "}

    """ Omnisharp: {
        " let g:OmniSharp_server_stdio = 0
        " let g:OmniSharp_diagnostic_showid = 1
        " let g:OmniSharp_selector_ui = 'fzf'
        " let g:Omnisharp_want_snippet = 1
        " let g:OmniSharp_open_quickfix = 0
        " let g:omnicomplete_fetch_full_documentation = 1
        "
        " augroup omnisharp_commands
        "     autocmd!
        "
        "     autocmd CursorHold *.cs OmniSharpTypeLookup
        "     autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
        "     autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
        "     autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
        "
        "     " Navigate up and down by method/property/field
        "     autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
        "     autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
        "     " Find all code errors/warnings for the current solution and populate the quickfix window
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
        "     " Contextual code actions (uses fzf, CtrlP or unite.vim when available)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
        "     autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
        "
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)
        "
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osrn <Plug>(omnisharp_rename)
        "
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
        "     autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
        " augroup END
    "}

    """ Undotree: {
        nnoremap <leader>ut :UndotreeToggle<CR>
    "}

    """ Vim-Clap: {
        nnoremap <leader>f :Clap files<CR>
        nnoremap <leader>TT :Clap proj_tags<CR>
        nnoremap <leader>T :Clap tags<CR>
        nnoremap <leader>b :Clap buffers<CR>
        nnoremap <leader>/ :Clap grep ++query=<cword><CR>
        nnoremap <leader>// :Clap grep<CR>
        nnoremap <leader>h :Clap help_tags<CR>
        nnoremap <leader>m :Clap marks<CR>
        nnoremap <leader>y :Clap yanks<CR>
        nnoremap <leader>r :Clap registers<CR>
        nnoremap <leader>l :Clap lines<CR>
        nnoremap <leader>qf :Clap quickfix<CR>
    "}

    """ Vim-Fugitive: {
        nnoremap <leader>gb :Gblame<CR>
        nnoremap <leader>gl :Glog<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gg :G<CR>

        nnoremap <leader>dg :diffget<CR>
    "}

    """ Vim-Rooter: {
        let g:rooter_patterns = ['*.csproj', '*.sln', '.projections.json', 'Makefile', '.git', '.git/']
        let g:rooter_change_directory_for_non_project_files = 'current'
    "}

    """ Vim-Sneak: {
        let g:sneak#label = 1
        let g:sneak#use_ic_scs = 1
    "}

    """ Vim-Test: {
        let test#strategy = 'asyncrun'
        let test#csharp#runner = 'dotnettest'
        nmap <silent> <leader>tn :TestNearest<CR>
        nmap <silent> <leader>tf :TestFile<CR>
        nmap <silent> <leader>ts :TestSuite<CR>
        nmap <silent> <leader>tl :TestLast<CR>
        nmap <silent> <leader>tg :TestVisit<CR>
    "}

    """ Vimspector: {
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
    "}
"}

""" Filetype: {
    au BufRead,BufNewFile *.xaml setfiletype xml
"}

""" Commands: {
    ":R [command]
    :command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
"}

""" Mappings: {
    nnoremap <leader>co :copen<CR>
    nnoremap <leader>cc :cclose<CR>
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
    set shortmess=a
    colorscheme gruvbox
    set background=dark
    set nohls
    set hidden
    set lazyredraw
    set autoread
    set foldmethod=indent
    set nofoldenable
    set backup
    set writebackup
    set backupdir=.backup/,~/.backup/,/tmp//
    set directory=.swp/,~/.swp/,/tmp//
    set undofile
    set undodir=.undo/,~/.undo/,/tmp//
    set signcolumn=yes
    set completeopt=menuone,noselect,noinsert,preview
    set completepopup=highlight:Pmenu,border:off
" }
