" .vimrc
" Author: Ádám Barancsuk <adam.barancsuk@gmail.com>
" Source: .vimrc by Steve Losh <steve@stevelosh.com> (http://bitbucket.org/sjl/dotfiles/src/tip/vim

" Preamble ------------------------------------------------------------------------------------ {{{

	call pathogen#infect()
	filetype plugin indent on
	set nocompatible

" }}}
" Basic options ------------------------------------------------------------------------------- {{{

	set autoindent
	set autoread
	set autowrite
	set backspace=indent,eol,start
	set cpoptions+=J
	set dictionary=/usr/share/dict/words
	set encoding=utf-8
	set fillchars=diff:⣿
	set hidden
	set history=1000
	set laststatus=2
	set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
	set matchtime=3
	set mouse=a
	set norelativenumber
	set number
	set ruler
	set shell=/bin/bash
	set shiftround
	set showbreak=↪
	set showcmd
	set showmode
	set splitbelow
	set splitright
	set title
	set ttyfast
	set undofile
	set undoreload=10000

" }}}
" Wildmenu completion ------------------------------------------------------------------------- {{{

	set wildmenu
	set wildmode=list:longest

	set wildignore+=.hg,.git,.svn                    " Version control
	set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
	set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
	set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
	set wildignore+=*.spl                            " compiled spelling word lists
	set wildignore+=*.sw?                            " Vim swap files
	set wildignore+=*.DS_Store                       " OSX bullshit

	set wildignore+=*.luac                           " Lua byte code

	set wildignore+=migrations                       " Django migrations
	set wildignore+=*.pyc                            " Python byte code

" }}}
" Tabs, spaces, wrapping ---------------------------------------------------------------------- {{{

	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set noexpandtab
	set wrap
	set textwidth=100
	set formatoptions=qrn1
	set colorcolumn=+1

" }}}
" Backups ------------------------------------------------------------------------------------- {{{

	set undodir=~/.vim/tmp/undo//     " undo files
	set backupdir=~/.vim/tmp/backup// " backups
	set directory=~/.vim/tmp/swap//   " swap files
	set backup                        " enable backups

" }}}
" Leader key ---------------------------------------------------------------------------------- {{{

	let mapleader = ","
	let maplocalleader = ";"

" }}}
" Colors -------------------------------------------------------------------------------------- {{{

	syntax on
	set t_Co=256
	let g:molokai_original=1
	colorscheme molokai

" }}}
" Status line --------------------------------------------------------------------------------- {{{

	augroup ft_statuslinecolor
		au!
		au InsertEnter * hi StatusLine ctermfg=237 guifg=#5D5C54
		au InsertLeave * hi StatusLine ctermfg=235 guifg=#3B3A32
	augroup END

	hi StatusLine ctermfg=235 guifg=#3B3A32

	set statusline=%f    " Path.
	set statusline+=%m   " Modified flag.
	set statusline+=%r   " Readonly flag.
	set statusline+=%w   " Preview window flag.

	set statusline+=\    " Space.

	set statusline+=%=   " Right align.

	" File format, encoding and type.  Ex: "(unix/utf-8/python)"
	set statusline+=(
	set statusline+=%{&ff}                        " Format (unix/DOS).
	set statusline+=, 
	set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
	set statusline+=, 
	set statusline+=%{&ft}                        " Type (python).
	set statusline+=)

	" Line and column position and counts.
	set statusline+=\ (L\ %l\/%L,\ C\ %3c)

" }}}
" Searching and movement ---------------------------------------------------------------------- {{{

	nnoremap / /\v
	vnoremap / /\v

	set gdefault
	set hlsearch
	set ignorecase
	set incsearch
	set showmatch
	set smartcase

	set scrolloff=3
	set sidescroll=1
	set sidescrolloff=10

	set virtualedit+=block

	noremap <leader><space> :noh<cr>:call clearmatches()<cr>

	map <tab> %

	nnoremap D d$
	nnoremap n nzzzv:call PulseCursorLine()<cr>
	nnoremap N Nzzzv:call PulseCursorLine()<cr>
	nnoremap * *<c-o>

	" Open a Quickfix window for the last search.
	nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

	function! PulseCursorLine() " {{{
		let current_window = winnr()
		windo set nocursorline
		execute current_window . 'wincmd w'
		setlocal cursorline

		redir => old_hi
			silent execute 'hi CursorLine'
		redir END
		let old_hi = split(old_hi, '\n')[0]
		let old_hi = substitute(old_hi, 'xxx', '', '')

		hi CursorLine guibg=#514f46 ctermbg=233
		redraw
		sleep 15m

		hi CursorLine guibg=#65625b ctermbg=235
		redraw
		sleep 15m

		hi CursorLine guibg=#787670 ctermbg=237
		redraw
		sleep 15m

		hi CursorLine guibg=#8b8984 ctermbg=239
		redraw
		sleep 15m

		hi CursorLine guibg=#787670 ctermbg=237
		redraw
		sleep 15m

		hi CursorLine guibg=#65625b ctermbg=235
		redraw
		sleep 15m

		hi CursorLine guibg=#514f46 ctermbg=233
		redraw
		sleep 15m

		execute 'hi ' . old_hi

		windo set cursorline
		execute current_window . 'wincmd w'
	endfunction
	" }}}

" }}}
" Folding ------------------------------------------------------------------------------------- {{{

	set foldlevelstart=0

	nnoremap <Space> za
	vnoremap <Space> za

	nnoremap <leader>z zMzvzz

	function! MyFoldText() " {{{
		let line = getline(v:foldstart)

		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3
		let foldedlinecount = v:foldend - v:foldstart

		" expand tabs into spaces
		let onetab = strpart('          ', 0, &tabstop)
		let line = substitute(line, '\t', onetab, 'g')

		let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
		let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
		return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' '
	endfunction " }}}
	set foldtext=MyFoldText()

" }}}
" GUI ----------------------------------------------------------------------------------------- {{{

	if has('gui_running')
		set guifont=Monospace\ 9

		set columns=130
		set lines=50

		set go-=T
		set go-=l
		set go-=L
		set go-=r
		set go-=R
"		set go-=m
		set go-=e

		highlight SpellBad term=underline gui=undercurl guisp=Orange

		set fillchars+=vert:│
	endif

" }}}
" Plugins ------------------------------------------------------------------------------------- {{{

	" NERD Tree {{{

		noremap  <F2> :NERDTreeToggle<cr>
		inoremap <F2> <esc>:NERDTreeToggle<cr>

		au Filetype nerdtree setlocal nolist

		let NERDTreeHighlightCursorline=1
		let NERDTreeIgnore=['\~$', '.*\.pyc$', 'xapian_index', '.*.pid',  '.*\.o$', 'db.db']

		let NERDTreeMinimalUI = 1
		let NERDTreeDirArrows = 1

	"}}} 
	" Org mode {{{

		let g:org_agenda_files = ['/data/documents/todo.org']
		let g:org_plugins = ['ShowHide', '|', 'Navigator', 'EditStructure', '|', 'Todo', 'Date', 'Misc']
		let g:org_todo_keywords = ['TODO', '|', 'DONE']
		let g:org_debug = 1

	"}}}
	" Zen coding {{{
	
		:imap <S-CR> <C-y>,

	"}}}

" }}}
" Miscellanea --------------------------------------------------------------------------------- {{{
	
	" Alternative tab switching {{{

		:nmap <C-S-tab> :tabprevious<CR>
		:nmap <C-tab> :tabnext<CR>
		:nmap <C-w> :q<CR>
		:map <C-S-tab> :tabprevious<CR>
		:map <C-tab> :tabnext<CR>
		:map <C-w> :q<CR>
		:imap <C-S-tab> <Esc>:tabprevious<CR>i
		:imap <C-tab> <Esc>:tabnext<CR>i
		:imap <C-w> <Esc>:q<CR>
		:nmap <C-t> :tabnew<CR>
		:imap <C-t> <Esc>:tabnew<CR>

	" }}}

	" Quick-edit files
	nnoremap <leader>v <C-w>s<C-w>j:e $MYVIMRC<cr>
	nnoremap <leader>t <C-w>s<C-w>j:e /data/documents/todo.org<cr>

	" Reformat paragraphs
	nnoremap Q gqip

	" Autocompletion
	set completeopt=longest,menuone,preview

	" Save as root
	cmap w!! w !sudo tee % >/dev/null

	"Resize splits when the window is resized
	au VimResized * exe "normal! \<c-w>="

	" Shortcuts for file types
	nnoremap _h :set ft=html<CR>
	nnoremap _p :set ft=php<CR>
	nnoremap _c :set ft=css<CR>

	" Scratch pad shortcut
	command! ScratchToggle call ScratchToggle()
	function! ScratchToggle() " {{{
	if exists("w:is_scratch_window")
		unlet w:is_scratch_window
		exec "q"
	else
		exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
		let w:is_scratch_window = 1
	endif
	endfunction " }}}

	nnoremap <silent> <leader><tab> :ScratchToggle<cr>

" }}}
