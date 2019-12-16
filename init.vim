"Space as learder
let mapleader=" "

set nocompatible
filetype plugin indent on

""" Init Config: {
    if has("unix")
        let g:vimDirectory = "~/.local/share/nvim/site"
        let g:userDirectory = "~/.config/nvim"
    else
        let g:vimDirectory  = "M:/swp/"
        let g:userDirectory = g:vimDirectory
        let g:python3_host_prog='C:\Python37\python.exe'
    end
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

        let g:airline#extensions#coc#enabled = 1

        let g:airline#extensions#tabline#buffer_nr_show = 0
        let g:airline#extensions#tabline#formatter = 'unique_tail'

        let g:airline#extensions#neomake#enabled = 1
    " }
    " Themeing: {
        Plug 'ryanoasis/vim-devicons'
    " }

    """ Syntax/Formatting
    " Auto Complete: {
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

        let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-powershell', 'coc-json', 'coc-yank', 'coc-snippets', 'coc-marketplace', 'coc-highlight' ]
        " if hidden is not set, TextEdit might fail.
        set hidden

        " Some servers have issues with backup files, see #649
        set nobackup
        set nowritebackup

        " Better display for messages
        set cmdheight=2

        " You will have bad experience for diagnostic messages when it's default 4000.
        set updatetime=300

        " don't give |ins-completion-menu| messages.
        set shortmess+=c

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)

        " Remap for format selected region
        xmap <leader>cf  <Plug>(coc-format-selected)
        nmap <leader>cf  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Create mappings for function text object, requires document symbols feature of languageserver.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use `:Format` to format current buffer
        command! -nargs=0 Format :call CocAction('format')

        " Use `:Fold` to fold current buffer
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " use `:OR` for organize import of current buffer
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
    " }
    " Language Server {
        Plug 'OmniSharp/omnisharp-vim', {'for': 'cs'}
        Plug 'OmniSharp/csharp-language-server-protocol', {'for': 'cs'}
        augroup omnisharp_commands
            autocmd!

            " Update the highlighting whenever leaving insert mode
            autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

            " Alternatively, use a mapping to refresh highlighting for the current buffer
            autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

            " The following commands are contextual, based on the cursor position.
            autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

            " Finds members in the current buffer
            autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
            autocmd FileType cs nnoremap <Leader><space> :OmniSharpGetCodeActions<CR>
        augroup END

        let g:OmniSharp_server_stdio = 0
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
        Plug 'airblade/vim-gitgutter'
    " }
    " DataBase: {
        Plug 'tpope/vim-dadbod'
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
    " Style: {
        Plug 'ncm2/float-preview.nvim'
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

        let g:rooter_patterns = ['**/*.sln', '.projections.json', '.git', '.git/', 'makefile']
        let g:rooter_change_directory_for_non_project_files = 'current'
    " }
    " Start Menu: {
        Plug 'mhinz/vim-startify'
    " }
    " Timing Startup: {
        Plug 'tweekmonster/startuptime.vim'
    " }
    " Reload: {
        Plug 'djoshea/vim-autoread'
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
