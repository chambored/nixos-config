
" Turn on line numbers
set number

" Set tab size and the equivalent number of spaces for a tab character
set tabstop=4
set shiftwidth=4
set expandtab

" Enable auto-indentation
set smartindent

" Set black and white color scheme
colorscheme desert

" Enable the mouse for all modes
set mouse=a

" Show a visual line under the cursor's current line
set cursorline

" Set up status line to include the current page number (pagenr)
set laststatus=2
set statusline=%<%f\ %h%m%r%{&ff}\ %{&fenc!=?&fenc:&enc}\ %w\ \|\ %l,%c%V\ %P

" Search configurations
" Highlight search results
set hlsearch
" Search as characters are entered
set incsearch
" Make search case insensitive unless there's a capital letter in the query
set ignorecase
set smartcase

" Wrap long lines
set wrap

" Show command in the bottom bar as you type it
set showcmd

" Enable syntax highlighting
syntax enable

" Use Unix as the default file type
set fileformat=unix

map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>
