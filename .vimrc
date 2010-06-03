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

" set expandtab       " turns tabs into spaces
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
let g:sh_fold_enabled		= 1

function! SvnBlameCurrentLine()
  let l:line  = line('.')
  let l:file  = expand("%:t")
  let l:wd    = expand("%:p:h")
  let content = system("cd " . l:wd . ";svn blame " . l:file . " | awk 'NR==" . l:line . "{print}' " .  ' | sed -n -e "s/\s\+\([0-9]\+\)\s\+\(\S\+\).*/\2 (\1)/p"' )
  let line = split(content, '\n')[0]
  echohl Type | echo line | echohl None
endfunction

function! GitBlameCurrentLine()
  let l:line  = line('.')
  let l:file  = expand("%:t")
  let l:wd    = expand("%:p:h")
  let content = system("cd " . l:wd . ";git blame -L ". l:line . "," . l:line . " " . l:file . " | sed 's/).*/)/'")
  let line = split(content, '\n')[0]
  echohl Type | echo line | echohl None
endfunction

function! BlameCurrentLine()
	let wd = getcwd()
	if isdirectory ( wd . "/.git" )
		:call GitBlameCurrentLine()
	elseif isdirectory ( wd . "/.svn" )
		:call SvnBlameCurrentLine()
	else
		echohl Type | echo "No SCM Detected in this directory" | echohl None
	endif
endfunction

command! BlameCurrentLine :call BlameCurrentLine()
map <C-i> :BlameCurrentLine<CR>

" mapping for Tasklist
map T :TaskList<CR>

" mapping for taglist
nnoremap <silent> <F8> :TlistToggle<CR>

set visualbell
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType perl set omnifunc=perlcomplete#Complete

