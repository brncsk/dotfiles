" .vimrc
" Author: Ádám Barancsuk <adam.barancsuk@gmail.com>
" Source: .vimrc by Steve Losh <steve@stevelosh.com> [http://bitbucket.org/sjl/dotfiles/src/tip/vim]

" Preamble ------------------------------------------------------------------------------------ {{{

	" TODO: enable this as soon as the background color erase bug is gone from 24-bit color enabled VTE
	"let &t_8f="\e[38:2:%ld:%ld:%ldm"
	"let &t_8b="\e[48:2:%ld:%ld:%ldm"
	"	set guicolors

	let g:Powerline_symbols="fancy"
	filetype plugin indent on
	set nocompatible

	set rtp +=~/.vim/bundle/Vundle.vim
	call vundle#begin()

		Plugin 'gmarik/Vundle.vim'

		Plugin 'tomasr/molokai'

		Plugin 'tikhomirov/vim-glsl', { 'name': 'glsl' }
		Plugin 'calvinchengx/vim-mapserver', { 'name': 'mapserver'}
		Plugin 'tkztmk/vim-vala', { 'name': 'vala' }
		Plugin 'fs111/pydoc.vim', { 'name': 'pydoc' }
		Plugin 'JuliaLang/julia-vim', { 'name': 'julia' }
		"Plugin 'taglist'
		Plugin 'scrooloose/nerdtree'
		Plugin 'brncsk/vim-powerline', { 'name': 'powerline' }

		"Plugin 'txtfmt'
		Plugin 'mattn/emmet-vim', { 'name': 'emmet' }
		Plugin 'tpope/vim-fugitive', { 'name': 'fugitive' }
		Plugin 'edsono/vim-matchit', { 'name': 'matchit' }
		Plugin 'mtth/scratch.vim', { 'name': 'scratch' }

	call vundle#end()

" }}}
" Basic options ------------------------------------------------------------------------------- {{{

	set autoindent
	set autoread
	set autowrite
	set backspace	 =indent,eol,start
	set completeopt	 =longest,menuone,preview
	set cpoptions	+=J
	set dictionary	 =/usr/share/dict/words
	set encoding	 =utf-8
	set fillchars	 =diff:⣿
	set hidden
	set history		 =1000
	set laststatus	 =2
	set listchars	 =tab:▸\ ,eol:¬,extends:❯,precedes:❮
	set matchtime	 =3
	set mouse		 =a
	set number
	set ruler
	set shell		 =/bin/bash
	set shiftround
	set showbreak	 =↪
	set showcmd
	set showmode
	set splitbelow
	set splitright
	set title
	set ttyfast
	set undofile
	set undoreload	 =10000
	set exrc
" }}}
" Wildmenu completion ------------------------------------------------------------------------- {{{

	set wildmenu
	set wildmode	 =list:longest

	set wildignore	+=.hg,.git,.svn						" Version control
	set wildignore	+=*.aux,*.out,*.toc					" LaTeX intermediate files
	set wildignore	+=*.jpg,*.bmp,*.gif,*.png,*.jpeg	" binary images
	set wildignore	+=*.o,*.obj,*.exe,*.dll,*.manifest	" compiled object files
	set wildignore	+=*.class							" Java bytecode
	set wildignore	+=*.spl								" compiled spelling word lists
	set wildignore	+=*.sw?								" Vim swap files
	set wildignore	+=*.DS_Store						" OSX bullshit
	set wildignore	+=*.pyc								" Python byte code

" }}}
" Tabs, spaces, wrapping ---------------------------------------------------------------------- {{{

	set tabstop			=4
	set shiftwidth		=4
	set softtabstop		=4
	set noexpandtab
	set wrap
	set textwidth		=100
	set formatoptions	=qrn1tc
	set colorcolumn		=+1

" }}}
" Backups ------------------------------------------------------------------------------------- {{{

	set undodir		=~/.vim/tmp/undo//		" Undo files
	set backupdir	=~/.vim/tmp/backup//	" Backups
	set directory	=~/.vim/tmp/swap//		" Swap files
	set backup								" Enable backups

" }}}
" Leader keys --------------------------------------------------------------------------------- {{{

	let mapleader		= ","
	let maplocalleader	= ";"

" }}}
" Colors -------------------------------------------------------------------------------------- {{{

	set t_Co				=256
	set background			=dark
	let g:molokai_original	=1
	colorscheme molokai
	syntax on

" }}}
" Tabline ------------------------------------------------------------------------------------- {{{
	
	if exists("+showtabline")
		set showtabline=0

		autocmd FocusGained * echo 'FocusGained'

		autocmd VimEnter,BufAdd,BufCreate,FileWritePost,BufEnter,BufUnload,FocusGained * call UpdateTablist()
		function! UpdateTablist()
			let i = 1
			let t = tabpagenr()
			let tablist = []
			while i <= tabpagenr('$')
				let buflist = tabpagebuflist(i)
				let winnr = tabpagewinnr(i)
				let bufnr = buflist[winnr - 1]

				call extend(tablist, [((i == t) ? '>' : '')
							\ . fnamemodify(bufname(bufnr), ':p:t')
							\ . (getbufvar(buflist[winnr - 1], "&mod") ? '*' : '')
							\ ])
				let i = i + 1
			endwhile
			call writefile(tablist, $HOME.'/.tmux/.vim-tablist')
			silent !tmux refresh-client -S
		endfunction

		autocmd FocusLost * silent! rm $HOME.'/.tmux/.vim-tablist'
	endif
	
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

	set scrolloff		 =3
	set sidescroll		 =1
	set sidescrolloff	 =10

	set virtualedit		+=block

	noremap		<leader><Space>		:noh<CR>:call clearmatches()<CR>
	map			<tab>				%
	nnoremap	D					d$
	nnoremap	n					nzzzv:call PulseCursorLine()<CR>
	nnoremap	N					Nzzzv:call PulseCursorLine()<CR>
	nnoremap	*					*<c-o>
	nnoremap	<silent> <leader>/	:execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

	function! PulseCursorLine () " {{{
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

	function! MyFoldText () " {{{
		let line = getline(v:foldstart)

		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3
		let foldedlinecount = v:foldend - v:foldstart

		" Expand tabs into spaces
		let onetab = strpart('          ', 0, &tabstop)
		let line   = substitute(line, '\t', onetab, 'g')
		let line   = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
		let fillcharcount = windowwidth - len(line) - len(foldedlinecount)

		return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' '
	endfunction " }}}


	set foldlevelstart	=0
	set foldtext		=MyFoldText()
	
	nnoremap <Space>	za
	vnoremap <Space>	za

	nnoremap <leader>z	zMzvzz

" }}}
" GUI ----------------------------------------------------------------------------------------- {{{

	if has('gui_running')
		set guifont		 =Monospace\ 9
		set columns		 =160
		set lines		 =50
		set go			-=e
		set go			-=l
		set go			-=L
		set go			-=r
		set go			-=R
		set go			-=T
		set fillchars	+=vert:│

		highlight SpellBad term=underline gui=undercurl guisp=Orange
	endif

" }}}
" Plugins ------------------------------------------------------------------------------------- {{{

	" NERD Tree {{{
		nnoremap <F2> :NERDTreeToggle<CR>
		inoremap <F2> <ESC>:NERDTreeToggle<CR>

		au Filetype nerdtree setlocal nolist

		let NERDTreeHighlightCursorline	= 1
		let NERDTreeMinimalUI			= 1
		let NERDTreeDirArrows			= 1
		let NERDTreeShowBookmarks		= 1
	" }}} 
	" Zen coding {{{
		:inoremap <C-Tab> <C-y>,
	" }}}
" }}}
" Miscellanea --------------------------------------------------------------------------------- {{{
	
	" GTK+-esque tab switching {{{
		nmap		<C-t>		:tabnew<CR>
		nmap		<ESC>{g		gT
		nmap		<ESC>{h		gt
		imap		<C-t>		<Esc>:tabnew<CR>
		imap		<ESC>{g		<ESC>gTi
		imap		<ESC>{h		<ESC>gti
	" }}}

	" Vala
		autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
		au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

	" GAMS
		au BufRead,BufNewFile *.gms setfiletype gams

	" MapServer
		au BufRead,BufNewFile *.map setfiletype map

	" NOOOOO
		nnoremap	:W			:w

	" Quick-edit frequent stuff in split 
		nnoremap	<leader>v	<C-w>s<C-w>j:e $MYVIMRC<CR>
		nnoremap	<leader>r	:source $MYVIMRC<CR>

		set clipboard=unnamed

	" Reformat paragraphs
		nnoremap	Q			gqip

	" Save as root
		cmap		w!!			w !sudo tee % >/dev/null

	" Resize splits when the window is resized
		au VimResized * exe "normal! \<c-w>="
" }}}
