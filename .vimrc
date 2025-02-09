" Enable syntax highlighting
syntax on
filetype plugin indent on

" Basic settings
set number              " Show line numbers
set expandtab          " Use spaces instead of tabs
set tabstop=2         " 2 spaces for tabs
set shiftwidth=2      " 2 spaces for indentation
set softtabstop=2     " 2 spaces for soft tabs
set autoindent        " Auto-indent new lines
set smartindent       " Smart indent
set showmatch         " Show matching brackets
set ruler             " Show cursor position
set cursorline        " Highlight current line
set incsearch         " Incremental search
set hlsearch          " Highlight search results

" Enable better colors
set termguicolors     " Enable true colors support
set background=dark   " Use dark background

" File type detection
au BufNewFile,BufRead *.yaml,*.yml set filetype=yaml
au BufNewFile,BufRead *.py set filetype=python
au BufNewFile,BufRead */playbooks/*.yml set filetype=yaml.ansible
au BufNewFile,BufRead */roles/*.yml set filetype=yaml.ansible
au BufNewFile,BufRead *.sh set filetype=sh
au BufNewFile,BufRead *.zsh set filetype=zsh
au BufNewFile,BufRead *.js,*.jsx set filetype=javascript
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
au BufNewFile,BufRead *.tf set filetype=terraform
au BufNewFile,BufRead *.hcl set filetype=hcl
au BufNewFile,BufRead *.conf set filetype=conf
au BufNewFile,BufRead *.toml set filetype=toml

" YAML specific settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Enable specific syntax highlighting
let g:ansible_extra_keywords_highlight = 1
let g:ansible_name_highlight = 'd'
let g:ansible_normal_keywords_highlight = 'Constant'

" Set color scheme (uncomment one of these if you have them installed)
" colorscheme molokai
" colorscheme solarized
" colorscheme gruvbox
" colorscheme dracula

" Status line configuration
set laststatus=2      " Always show status line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" Additional useful settings
set backspace=indent,eol,start  " Make backspace work as expected
set hidden             " Allow switching buffers without saving
set wildmenu          " Command line completion
set wildmode=list:longest
set scrolloff=8       " Keep 8 lines above/below cursor
set encoding=utf-8    " Use UTF-8 encoding
set nobackup          " Don't create backup files
set nowritebackup     " Don't create backup files while editing
set noswapfile        " Don't create swap files

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Make vim respect kubectl yaml templates
autocmd FileType yaml if (match(expand('%:p'), 'kubectl') != -1) | set ft=yaml.kubectl | endif

