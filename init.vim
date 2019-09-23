"Space as learder
let mapleader=" "

set nocompatible
filetype plugin indent on

""" Init Config: {
    if has("nvim")
        if has("unix")
            let g:vimDirectory = "~/.local/share/nvim/site"
            let g:userDirectory = "~/.config/nvim"
        else
            let g:vimDirectory  = 'C:/Users/'. $username. '/AppData/Local/nvim'
            let g:userDirectory = g:vimDirectory
        end
    endif
" }

""" Plugins: {
    call plug#begin()

    """ Themeing
    " Airline: {
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        let g:airline_detect_modified= 1
        let g:airline_detect_spell= 1
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#wordcount#enabled = 1
        let g:airline#extensions#whitespace#enabled = 1

        let g:airline#extensions#ale#enabled = 1

        let g:airline#extensions#tabline#buffer_nr_show = 0
        let g:airline#extensions#tabline#formatter = 'unique_tail'

        let g:airline#extensions#languageclient#enabled = 1
        let g:airline#extensions#neomake#enabled = 1
    " }
    " Themeing: {
        Plug 'ryanoasis/vim-devicons'
    " }

    """ Syntax/Formatting
    " ALE: {
        Plug 'w0rp/ale'

        let g:ale_completion_enabled = 1
        let g:ale_fix_on_save = 1
        let g:ale_linters = {
                    \   'cs':['OmniSharp']
                    \}
        let g:ale_fixers = {
                    \   '*':['trim_whitespace', 'remove_trailing_lines'],
                    \   'xml':['tidy', 'trim_whitespace', 'remove_trailing_lines'],
                    \   'html':['prettier', 'trim_whitespace', 'remove_trailing_lines'],
                    \   'cs':['uncrustify', 'trim_whitespace', 'remove_trailing_lines'],
                    \   'java':['uncrustify', 'trim_whitespace', 'remove_trailing_lines'],
                    \   'json':['prettier', 'trim_whitespace', 'remove_trailing_lines'],
                    \}
    " }
    " Deoplete: {
        Plug 'Shougo/deoplete.nvim'

        let g:deoplete#enable_at_startup = 1
        let g:deoplete#auto_complete_start_length = 1
        if has('win32')
            let g:python3_host_prog='C:\Python37\python.exe'
        endif

        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " }
    " NeoSnippet: {
        Plug 'Shougo/neosnippet.vim'
        Plug 'Shougo/neosnippet-snippets'

        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        inoremap <S-Tab> <C-V><Tab>
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
        let g:neosnippet#snippets_directory = '~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
        let g:neosnippet#enable_snipmate_compatibility = 1
    " }
    " Language-Client: {
        Plug 'autozimu/LanguageClient-neovim', {
                    \ 'branch': 'future',
                    \ 'do': 'bash install.sh',
                    \ 'for': ['python', 'java'],
                    \ }
        Plug 'OmniSharp/omnisharp-vim', {'for': 'cs'}
        Plug 'OmniSharp/csharp-language-server-protocol', {'for': 'cs'}

        let g:LanguageClient_serverCommands = {
                    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
                    \ 'python': ['pyls'],
                    \ }

        function! LC_maps()
            if has_key(g:LanguageClient_serverCommands, &filetype)
                nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
                nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
                nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
                nnoremap <buffer> <silent> <Leader><space> :call LanguageClient_contextMenu()<CR>
            endif
        endfunction

        autocmd FileType * call LC_maps()
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
            autocmd FileType cs nnoremap <Leader><space> :OmniSharpGetCodeActions<CR>
            autocmd FileType cs nnoremap <F2> :OmniSharpRename<CR>

            " Run Tests
            autocmd FileType cs nnoremap <leader>rt :OmniSharpRunTests<cr>
            autocmd FileType cs nnoremap <leader>rf :OmniSharpRunTestFixture<cr>
            autocmd FileType cs nnoremap <leader>ra :OmniSharpRunAllTests<cr>
            autocmd FileType cs nnoremap <leader>rl :OmniSharpRunLastTests<cr>
        augroup END

        let g:OmniSharp_server_stdio = 0
    " }
    " Make and Test: {
        Plug 'neomake/neomake'
        Plug 'janko-m/vim-test'
        Plug 'tpope/vim-projectionist'
        Plug 'tpope/vim-dispatch'

        let test#strategy = "dispatch"
        nmap <silent> t<C-n> :TestNearest<CR>
        nmap <silent> t<C-f> :TestFile<CR>
        nmap <silent> t<C-s> :TestSuite<CR>
        nmap <silent> t<C-l> :TestLast<CR>
        nmap <silent> t<C-g> :TestVisit<CR>
    " }
    " Debug: {
        Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    " }
    " Git: {
        Plug 'tpope/vim-fugitive'
        Plug 'ludovicchabant/vim-gutentags'
    " }
    " Finder: {
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'majutsushi/tagbar'

        let $FZF_DEFAULT_COMMAND='ag -g ""'

        nmap <Leader>f :Files<CR>
        nmap <Leader>g :GFiles<CR>
        nmap <Leader>t :Tags<CR>
        nmap <Leader>l :Lines<CR>
        nnoremap <Leader>b :Buffers<CR>
        map <Leader>mt :TagbarToggle<CR>
    " }
    " Syntax: {
        Plug 'sheerun/vim-polyglot'
        Plug 'andymass/vim-matlab', {'for': 'matlab'}
        Plug 'chrisbra/csv.vim'
        Plug 'heaths/vim-msbuild'

        au BufRead,BufNewFile *.xaml setfiletype xml
    " }
    " Formatting: {
        Plug 'tpope/vim-endwise'
        Plug 'tpope/vim-commentary'
        Plug 'prettier/vim-prettier'
        Plug 'Yggdroot/indentLine'
    " }

    """ Buffer Manangement
    " Denite: {
        Plug 'Shougo/denite.nvim'

        nnoremap <leader>" :Denite register<CR>
        nnoremap <leader>/ :Denite grep:.<CR>
    " }
    " NERD Tree: {
        Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
        nmap <leader>n :NERDTreeToggle<CR>
        let NERDTreeQuitOnOpen=1
    " }
    " Window Mangement: {
        Plug 'wesQ3/vim-windowswap'
        Plug 'simeji/winresizer'
        Plug 'dhruvasagar/vim-zoom'
    " }
    " Working Directory: {
        Plug 'airblade/vim-rooter'

        let g:rooter_patterns = ['.projectionist', '.git', '.git/', 'makefile']
        let g:rooter_change_directory_for_non_project_files = 'current'
    " }
    " Start Menu: {
        Plug 'mhinz/vim-startify'
    " }
    " Timing Startup: {
        Plug 'tweekmonster/startuptime.vim'
    " }

    call plug#end()
" }

""" Post Plugin Load: {
    " ALE: {
        nmap <silent> <leader>aj :ALENext<cr>
        nmap <silent> <leader>ak :ALEPrevious<cr>
    " }
    " Denite: {
        autocmd FileType denite call s:denite_my_settings()
            function! s:denite_my_settings() abort
              nnoremap <silent><buffer><expr> <CR>
              \ denite#do_map('do_action')
              nnoremap <silent><buffer><expr> d
              \ denite#do_map('do_action', 'delete')
              nnoremap <silent><buffer><expr> p
              \ denite#do_map('do_action', 'preview')
              nnoremap <silent><buffer><expr> q
              \ denite#do_map('quit')
              nnoremap <silent><buffer><expr> i
              \ denite#do_map('open_filter_buffer')
              nnoremap <silent><buffer><expr> <Space>
              \ denite#do_map('toggle_select').'j'
            endfunction

            autocmd FileType denite-filter call s:denite_filter_my_settings()
            function! s:denite_filter_my_settings() abort
              imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
            endfunction

        call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
        call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
        call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
        call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
    " }
    " NeoMake: {
        call neomake#configure#automake('w')
    " }
" }

""" Window Movement: {
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    set splitbelow
    set splitright
" }

""" Basic Remapping: {
    inoremap jk <ESC>
    nmap <leader>s :w<CR>
    nmap <leader>q :q<CR>
    nmap , za
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
" }

""" Function key remaps: {
    " Fix tab
    nnoremap <silent> <F3> mzgg=G`zzz
    " Run makefile
    nnoremap <silent> <F5> :make<CR>
" }

""" ScrollView: {
    set scrolloff=999
    if !exists('*VCenterCursor')
      augroup VCenterCursor
      au!
      au OptionSet *,*.*
        \ if and( expand("<amatch>")=='scrolloff' ,
        \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
        \   au! VCenterCursor WinEnter,WinNew,VimResized|
        \ endif
      augroup END
      function VCenterCursor()
        if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
          let s:default_scrolloff=&scrolloff
          let &scrolloff=winheight(win_getid())/2
          au VCenterCursor WinEnter,WinNew,VimResized *,*.*
            \ let &scrolloff=winheight(win_getid())/2
        else
          au! VCenterCursor WinEnter,WinNew,VimResized
          let &scrolloff=s:default_scrolloff
        endif
      endfunction
    endif

    nnoremap <leader>zz :call VCenterCursor()<CR>
"}

""" General: {
    set backupdir=g:userDirectory.'/backup',.
    set directory=g:userDirectory.'/backup',.
    set mouse=
" }

""" Styling: {
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
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set ignorecase
    set nohlsearch
    set foldmethod=indent
    set lazyredraw

    autocmd VimEnter * GuiFont! DejaVu\ Sans\ Mono\ for\ Powerline
" }
