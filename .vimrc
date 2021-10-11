"Dir Structure
" .vim/
"  |-- autoload/
"  |-- backup/
"  |-- colors/
"  |-- plugged/



set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number 
set cursorline
set shiftwidth=4 
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase 
set showcmd
set showmode 
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.pyc,*.exe,*.flv,*.img,*.xlsx
set splitright


" PLUGINS -----------------------------------------------{{{
" install VimPlug
"$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

    Plug 'OmniSharp/omnisharp-vim'              " For C# and dotnet support
    Plug 'tpope/vim-dispatch'                   " Loads OmniSharp server when C# file if opened
    Plug 'prabirshrestha/asyncomplete.vim'      " Autocompletion w/ Omni-vim
    Plug 'kien/ctrlp.vim'                       " Fuzzy finder for IDE like functionality
    Plug 'vim-airline/vim-airline'              " Vim statusline plugin
    Plug 'vim-airline/vim-airline-themes'       " Vim statusline themes
    Plug 'dense-analysis/ale'                   " Linter
    Plug 'preservim/nerdtree'                   " File tree 
    Plug 'scrooloose/syntastic'                 " Syntax highlighting plugin
    Plug 'raimondi/delimitmate'                 " Autoclose brackets
    Plug 'kien/rainbow_parentheses.vim'         " Bracket colors
  " Plug 'valloric/youcompleteme'               " Autocompleter


call plug#end()

" }}}

" MAPPINGS ----------------------------------------------{{{

" Run dotnet 
nnoremap <F5> :w <CR>:!clear <CR>:!dotnet run <CR>
" Toggle NerdTree
nnoremap <F3> :NERDTreeToggle<cr>
" Have nerdtree ignore certain files and dirs
let NERDTreeIgnore=['\.git$','\.jpg$','\.mp4$','.\ogg$','\.iso$','\.pdf$','\.pyc$','.odt$','\.png$','\.odt$','\.png$','\.gif$','\.db$']
let NERDTreeShowHidden=1





" Asyncomplete Mappings
" " Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" " Force refresh completion
imap <c-space> <Plug>(asyncomplete_force_refresh)

" OmniSharp configs
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_highlighting=0
set completeopt=longest,menuone,preview
set previewheight=5
augroup omnisharp_commands
    autocmd!
    autocmd CursorHold *.cs OmniSharpTypeLookup

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
    
    autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
    autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
augroup END

" }}}

" VIMSCRIPT ---------------------------------------------{{{

" Enable marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" HTML filetype settings
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" Enable backup file for undo changes after file save
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Split window into sections by typing `:split` or `:vsplit'
" Display cursorline only in active window
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline
augroup END

" If GUI version
if has('gui_running')
    set background=dark
    colorscheme slate
    set guifont=Monospace\ Regular\ 12
endif 

" }}}

" Show the status on the second to last line
set laststatus=2
