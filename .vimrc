command KR :%s/^\([[:space:]]*\<\(if\|for\|while\|do\)\>(.*)\)[[:space:]]*{/\1{/ | :noh

" for compiling and navigating between warning and errors
nnoremap <silent> <F9> :make<CR><CR>:cw<CR>
nnoremap <silent> <C-P> :cp <CR>
nnoremap <silent> <C-N> :cn <CR>
nnoremap <silent> <C-L> :cl <CR>

" playing a record
:nnoremap <Space> @q

set nobackup        " don't back up file before saving
set autowrite       " automatically save before making
set history=1000

set expandtab       " turns tabs into spaces
set tabstop=2       " number of spaces per tab
set autoindent
set smartindent
set cindent
set shiftwidth=4    " number of spaces per shift

set showmatch       " brace matching
syntax on           " syntax highlighting

set incsearch       " incremental search
set ignorecase      " search ignores case
set hlsearch        " highlight search results (":nohlsearch" unhighlights)


let g:BASH_AuthorName   = 'Zakaria ElQotbi'
let g:BASH_AuthorRef    = 'M'
let g:BASH_Email        = 'zakaria.elqotbi@openwide.fr'
let g:BASH_Company      = 'OpenWide, Paris'

function! GitBlameCurrentLine()
  let l:line  = line('.')
  let l:file  = expand("%:t")
  let l:wd    = expand("%:p:h")
  let content = system("cd " . l:wd . ";git blame -L ". l:line . "," . l:line . " " . l:file . " | sed 's/).*/)/'")
  let line = split(content, '\n')[0]
  echohl Type | echo line | echohl None
endfunction

command! GitBlameCurrentLine :call GitBlameCurrentLine()
map <C-i> :GitBlameCurrentLine<CR>

" mapping for Tasklist
map T :TaskList<CR>

" mapping for taglist
nnoremap <silent> <F8> :TlistToggle<CR>

set visualbell
