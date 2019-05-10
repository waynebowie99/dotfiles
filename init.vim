"Space as learder
let mapleader=" "

filetype plugin indent on

""" Init Config: {
    if has("nvim")
        if has("unix")
            let g:vimDirectory = "~/.local/share/nvim/site"
            let g:userDirectory = "~/.config/nvim"
        elseif has("win32") || has("win32unix")
            let g:vimDirectory = "~\AppData\Local\nvim"
            let g:userDirectory = "~\AppData\Local\nvim"
        end
    else
        if has("unix")
            let g:vimDirectory = "~/.vim"
            let g:userDirectory = "~/.vim"
        elseif has("win32") || has("win32unix")
            let g:vimDirectory = "~\vimfiles"
            let g:userDirectory = "~\vimfiles"
        endif
    endif
" }

""" Plugin Manager: (Vim-Plug)
    let VimPlugInitialized=1
    " Download plugin manager {
    if empty(glob(expand(g:vimDirectory . '/autoload/plug.vim')))
      let VimPlugInitialized=0
      " I know that all these could be replaced with just the git one. But I don't want to delete them
      if executable("curl")
        silent exec '!curl -fLo ' . shellescape(expand(g:vimDirectory."/autoload/plug.vim")) .
            \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      " If all else fails we can just use git.
      elseif executable("git")
        silent exec '!git clone -q --depth=1 git@github.com:junegunn/vim-plug.git ' . shellescape(expand(g:vimDirectory."/temp"))
        if has('gui_win32')
          let s:mv="move "
          let s:rm="del "
        else
          let s:mv="mv "
          let s:rm="rm -rf "
        endif
        silent exec '!' . s:mv . shellescape(expand(g:vimDirectory."/temp/plug.vim")) .
          \ ' ' . shellescape(expand(g:vimDirectory."/autoload/plug.vim"))
        silent exec '!' . s:rm . shellescape(expand(g:vimDirectory."/temp/"))
      else
        echo "Couldn't find a way to download Vim-Plug. Not sure how you were planning" .
          \ " installing plugins without Git."
      endif

      if has('nvim')
        " Install python client
        if HasExec('pip')
          silent exec '!pip install neovim'
        endif
        if HasExec('pip3')
          silent exec '!pip3 install neovim'
        endif
      endif
      function! InstallMyPlugs() abort
        silent! PlugUpdate
        if has('nvim')
          silent! UpdateRemotePlugins
        endif
      endfunction
      augroup PluginInstallation
        autocmd!
        autocmd VimEnter * call InstallMyPlugs()
      augroup END
    endif
" }

""" Plugins: {
    call plug#begin()

    """ Themeing
    " Airline: {
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
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
    " }
    " Themeing: {
        Plug 'ryanoasis/vim-devicons'
    " }

    """ Syntax/Formatting
    " ALE: {
        Plug 'w0rp/ale'

        let g:ale_completion_enabled = 1
        let g:ale_fix_on_save = 1
        "let g:ale_java_javac_classpath = '~/Programming/Java/'
        let g:ale_fixers = {
                    \   'java':['google_java_format', 'uncrustify', 'remove_trailing_lines', 'trim_whitespace'],
                    \   'json':['prettier', 'remove_trailing_lines', 'trim_whitespace'],
                    \   '': ['remove_trailing_lines', 'trim_whitespace']
                    \}
    " }
    " Deoplete: {
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

        let g:deoplete#enable_at_startup = 1
        if has('win32')
            let g:python3_host_prog='C:\Python37\python.exe'
        endif
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " }
    " Denite: {
        Plug 'Shougo/denite.nvim', { 'on': 'Denite' }

        nnoremap <leader>: :Denite command<CR>
        nnoremap <leader>" :Denite register<CR>
        nnoremap <leader>b :Denite buffer:!<CR>
        nnoremap <leader>R :Denite file_mru<CR>
        nnoremap <leader>/ :Denite grep:.<CR>
        call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
        call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
        call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
        call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
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
                    \ 'for': ['py', 'java'],
                    \ }
        Plug 'OmniSharp/omnisharp-vim', {'for': 'cs'}
        Plug 'OmniSharp/csharp-language-server-protocol', {'for': 'cs'}

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

        nnoremap <F6> :call LanguageClient_contextMenu()<CR>
        let g:LanguageClient_serverCommands = {
                    \ 'java': [g:userDirectory . '/jdtls', '-data', getcwd()],
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
    " }
    " Git: {
        Plug 'tpope/vim-fugitive'
        Plug 'ludovicchabant/vim-gutentags'
    " }
    " Finder: {
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
        map <C-p> :Files<CR>
        map <C-b> :TagbarToggle<CR>
    " }
    " Syntax: {
        Plug 'sheerun/vim-polyglot'
        Plug 'andymass/vim-matlab', {'for': 'matlab'}
    " }
    " Formatting: {
        Plug 'Yggdroot/indentLine'
        Plug 'rstacruz/vim-closer'
        Plug 'scrooloose/nerdcommenter'
    " }

    """ Buffer Manangement
    " NERD Tree: {
        Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTree']}
        nmap <leader>n :NERDTreeToggle<CR>
    " }
    " Window Mangement: {
        Plug 'wesQ3/vim-windowswap'
        Plug 'simeji/winresizer'
        Plug 'dhruvasagar/vim-zoom'
    " }
    " Start Menu: {
        Plug 'mhinz/vim-startify'
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

""" Basic Remapping: {
    inoremap jk <ESC>
    inoremap kj <ESC>
    nmap <leader>s :w!<CR>
    nmap <leader>q :q!<CR>
    nmap , za
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
    tnoremap kj <C-\><C-n>
" }

""" Function key remaps: {
    " Fix tab
    nnoremap <silent> <F3> mzgg=G`zzz
    " Run makefile
    nnoremap <silent> <F4> :make<CR>
    " Reload file
    nnoremap <silent> <F5> :e %<CR>
" }

""" General: {
    set backupdir=~/.config/nvim/backup,.
    set directory=~/.config/nvim/backup,.
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
    set guifont=Hack
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set ignorecase
    set nohlsearch
    set foldmethod=indent
" }
