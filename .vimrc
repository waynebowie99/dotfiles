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
        set guifont=FantasqueSansMono_Nerd_Font_Mon:h12
        set guioptions=icpM
        if has('win32') || has('win64')
            if (v:version == 704 && has("patch393")) || v:version > 704
                set renderoptions=type:directx,level:0.75,gamma:1.25,contrast:0.25,geom:1,renmode:5,taamode:1
            endif
        endif
    endif
" }

""" Plugins: {
    call plug#begin()

    Plug 'puremourning/vimspector'
    Plug 'justinmk/vim-sneak'
    Plug 'lilwayne1556/vim-azure-devops-toolbar'
    Plug 'cedarbaum/fugitive-azure-devops.vim'
    Plug 'sk1418/QFGrep'
    Plug 'preservim/tagbar'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
    Plug 'dense-analysis/ale'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'mhinz/vim-startify'
    Plug 'airblade/vim-rooter'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'prabirshrestha/asyncomplete.vim' | Plug 'prabirshrestha/asyncomplete-lsp.vim' | Plug 'prabirshrestha/asyncomplete-emmet.vim' | Plug 'laixintao/asyncomplete-gitcommit' | Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
    Plug 'skywind3000/asyncrun.vim' | Plug 'skywind3000/asynctasks.vim'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-projectionist'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'sheerun/vim-polyglot'
    Plug 'sirtaj/vim-openscad'
    Plug 'tomtom/tcomment_vim'
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'

    " Must be loaded after other plugins to be usable
    Plug 'ryanoasis/vim-devicons'

    call plug#end()
" }

""" Plugin Config: {
    """ Airline: {
        let g:airline_detect_modified = 1
        let g:airline_powerline_fonts = 1

        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#gutentags#enabled = 1
        let g:airline#extensions#fugitiveline#enabled = 1
        let g:airline#extensions#hunks#enabled = 1
        let g:airline#extensions#omnisharp#enabled = 1
        let g:airline#extensions#capslock#enabled = 1
        let g:airline#extensions#csv#enabled = 1

        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        let g:airline#extensions#quickfix#location_text = 'Location'

        autocmd VimEnter * let g:airline_symbols.linenr = ''
        autocmd VimEnter * let g:airline_symbols.maxlinenr = ''
    "}

    """ ALE: {
        let g:ale_linters ={
                    \ 'cs': ['OmniSharp']
                \}
        let g:ale_fixers = {
                    \ 'cs': ['uncrustify']
                \}
        nmap [g :ALEPrevious<CR>
        nmap ]g :ALENext<CR>
    "}

    """ AutoComplete: {
        call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
                \ 'name': 'ultisnips',
                \ 'allowlist': ['*'],
                \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
                \ }))

        call asyncomplete#register_source({
                \ 'name': 'gitcommit',
                \ 'whitelist': ['gitcommit'],
                \ 'priority': 10,
                \ 'completor': function('asyncomplete#sources#gitcommit#completor')
                \ })
    "}

    """ Gutentags: {
    let g:gutentags_ctags_extra_args = [
                \ '--tag-relative=yes',
                \ '--fields=+ailmnS',
                \ '--options=C:/Users/wayneb/default.ctags'
                \ ]
    "}

    """ Omnisharp: {
        let g:OmniSharp_server_stdio = 1
        let g:OmniSharp_diagnostic_showid = 1
        let g:OmniSharp_diagnostic_listen = 2
        let g:Omnisharp_want_snippet = 1
        let g:OmniSharp_open_quickfix = 1
        let g:omnicomplete_fetch_full_documentation = 1
        let g:OmniSharp_diagnostic_exclude_paths = [
                    \ 'obj\\',
                    \ '[Tt]emp\\',
                    \ '\.nuget\\',
                    \ '\<AssemblyInfo\.cs\>',
                    \ '\<Designer\.cs\>'
                    \]

        augroup omnisharp_commands
            autocmd!

            autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
            autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
            autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
            autocmd FileType cs nmap <silent> <buffer> <leader>gt <Plug>(omnisharp_type_lookup)
            autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
            autocmd FileType cs nmap <silent> <buffer> gs <Plug>(omnisharp_find_symbol)
            autocmd FileType cs nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
            autocmd FileType cs nmap <silent> <buffer> <Leader>tn <Plug>(omnisharp_run_test)
            autocmd FileType cs nmap <silent> <buffer> <Leader>tf <Plug>(omnisharp_run_tests_in_file)

            " Navigate up and down by method/property/field
            autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
            autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
            " Find all code errors/warnings for the current solution and populate the quickfix window
            autocmd FileType cs nmap <silent> <buffer> ge <Plug>(omnisharp_global_code_check)
            autocmd FileType cs nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)

            autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)

            autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
            autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
            autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
        augroup END
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

    """ Vim-Fugitive: {
        let g:fugitive_azure_devops_baseurl = 'pcidevops.petersoncontractors.com'
        nnoremap <leader>gb :GBrowse<CR>
        nnoremap <leader>gl :Gclog<CR>
        nnoremap <leader>glf :Gclog --follow -p %:p<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gg :Gedit :<CR>
        nnoremap <leader>gp :G pull<CR>

        nnoremap <leader>dg :diffget<CR>
    "}

    """ Rooter: {
        let g:rooter_patterns = ['Makefile', '.git', '.git/']
        let g:rooter_change_directory_for_non_project_files = 'current'
        let g:rooter_silent_chdir = 1
    "}

    """ Projectionist: {
        let g:projectionist_heuristics = {
            \ "*.xaml.cs": {
            \   "*.xaml": {"type": "alternate"}
            \ },
            \ "*.xaml": {
            \   "*.xaml.cs": {"type": "alternate"}
            \ }
        \}
    "}

    """ Start Menu: {
        nmap <leader>sm :Startify<CR>
        nmap <leader>ss :SSave<CR>
        nmap <leader>sl :SLoad<CR>
        nmap <leader>sd :SDelete<CR>
        nmap <leader>sc :SClose<CR>

        let g:startify_bookmarks = [
                    \'C:\Users\wayneb\source\Services\Services',
                        \'C:\Users\wayneb\source\VB6',
                        \'C:\Users\wayneb\source',
                        \$myvimrc,
                        \'C:\Users\wayneb\vimfiles\plugged\vim-azure-devops-toolbar']
    "}

    """ FZF: {
        nmap <leader>f :Files<CR>
        nmap <leader>b :Buffers<CR>
        nmap <leader>l :Lines<CR>
        nmap <leader>tg :Tags<CR>

        let g:FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
        let g:fzf_layout = { 'down': '40%' }
        if has('win32') || has('win')
            let g:fzf_preview_window = []
        endif
    "}

    """ Tagbar: {
        nmap <leader>tb :TagbarToggle<CR>
        let g:tagbar_type_vb = {
                    \ 'kinds': [
                        \'T:Types',
                        \'s:Sub Routines',
                        \'f:Functions',
                        \'E:Events',
                        \'v:Variables',
                        \'c:Constants',
                        \'p:Properties',
                        \'e:Enum',
                        \'l:Label',
                        \'u:Controls'
                    \],
                    \ 'deffile' : 'C:/Users/wayneb/default.ctags'
                \}
    "}

    """ Sneak: {
        let g:sneak#label = 1
        let g:sneak#use_ic_scs = 1
        nmap f <Plug>Sneak_f
        nmap F <Plug>Sneak_F
        nmap t <Plug>Sneak_t
        nmap T <Plug>Sneak_T
    "}

    """ Vimspector: {
        let g:vimspector_enable_mappings = 'HUMAN'
        nnoremap <F2> :VimspectorReset<CR>
    "}
"}

""" Filetype: {
    au BufRead,BufNewFile *.xaml setfiletype xml
    au BufRead,BufNewFile *.fil setfiletype csv
    au BufRead,BufNewFile *.cls setfiletype vb
    au BufEnter *.cs nmap <leader>ts :call TestCSharp()<CR>
    au User VimspectorUICreated setlocal mouse=a
    au User VimspectorDebugEnded setlocal mouse=
"}

""" Commands: {
    ":R [command]
    command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
    command! -nargs=* -complete=shellcmd FixWhitespace %s/\s\+$//e
    command! -nargs=1 -complete=shellcmd AddMigration cd *api | call system("dotnet ef migrations add " . <q-args>) | cd ..
"}

""" Functions: {
    function TestCSharp()
        call asyncrun#run('', '', 'dotnet test ' . globpath('.', '*.sln')[2:] .' -- xunit.parallelizeAssembly=true')
    endfunction
"}

""" Mappings: {
    nnoremap <leader>co :copen<CR>
    nnoremap <leader>cc :cclose<CR>
    nnoremap <C-W>\ <C-W>\| <C-W>_
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
    nmap <leader>mt :term ++curwin pwsh<CR>
    nmap <leader>/w :grep <cword><CR>
    nmap <leader>w :w<CR>
    nmap <leader>W :wa<CR>
    nmap <leader>q :q<CR>
    nmap <leader>Q :q!<CR>
    nnoremap <leader>dm :AddMirgration 
" }

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
    set grepformat=%f:%l:%c:%m
endif

""" Styling: {
    syntax on
    set encoding=utf8
    set mouse=
    set autoindent
    set copyindent
    set backspace=indent,eol,start
    set smartcase
    set ignorecase
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
    set shortmess=a
    colorscheme gruvbox
    set background=dark
    set lazyredraw
    set autoread
    set foldmethod=indent
    set nofoldenable
    set backup
    set writebackup
    set incsearch
    set nohlsearch
    set backupdir=.backup/,~/.backup/,/tmp//
    set directory=.swp/,~/.swp/,/tmp//
    set undofile
    set undodir=.undo/,~/.undo/,/tmp//
    set completeopt=menuone,noselect,noinsert,preview
    set completepopup=highlight:Pmenu,border:off
    set path+=**
    set wildmenu
    set wildmode=longest:full,full
    set wildignore+=*.git/*,*bin/*,*obj/*
    set hidden " Switch buffers without saving
    set showbreak=↪\ \
    set list
    set listchars=nbsp:␣,trail:•,extends:⟩,precedes:⟨
    set belloff=all
    set tags=./tags,tags;$HOME
    let g:netrw_nobeval=1
" }
