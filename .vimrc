" .vimrc
" Author: Ádám Barancsuk <adam.barancsuk@gmail.com>
" Source: .vimrc by Steve Losh <steve@stevelosh.com> [http://bitbucket.org/sjl/dotfiles/src/tip/vim]

" Preamble ------------------------------------------------------------------------------------ {{{

	call pathogen#infect()
	filetype plugin indent on
	set nocompatible

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
	set formatoptions	=qrn1
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
" Status line --------------------------------------------------------------------------------- {{{

	augroup ft_statuslinecolor
		au!
		au InsertEnter * hi StatusLine ctermfg=237 guifg=#5D5C54
		au InsertLeave * hi StatusLine ctermfg=235 guifg=#3B3A32
	augroup END

	hi StatusLine ctermfg=235 guifg=#3B3A32

	set statusline	 =%f							" Path
	set statusline	+=%m							" Modified flag
	set statusline	+=%r							" Readonly flag
	set statusline	+=%w							" Preview window flag
	set statusline	+=\ %=							" --- Right align
	set statusline	+=(								" (
	set statusline	+=%{&ff}                        " Format (unix/DOS)
	set statusline	+=,								" ,
	set statusline	+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8)
	set statusline	+=,								" ,
	set statusline	+=%{&ft}                        " Type (python)
	set statusline	+=)								" )
	set statusline	+=\ (L\ %l\/%L,\ C\ %3c)		" Line/col position/count

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
		let NERDTreeIgnore = ['\~$', '.*\.pyc$', 'xapian_index', '.*.pid',  '.*\.o$', 'db.db']


	"}}} 
	" Org mode {{{

		let g:org_agenda_files	= ['/data/documents/todo.org']
		let g:org_plugins		= ['ShowHide', 'Navigator', 'EditStructure', 'Todo', 'Date', 'Misc']
		let g:org_todo_keywords	= ['TODO', '|', 'DONE']
		let g:org_debug			= 1

	"}}}
	" Zen coding {{{
	
		:imap <S-CR> <C-y>,

	"}}}
	" Scratch pad {{{

		command! ScratchToggle call ScratchToggle()
		function! ScratchToggle ()
			if exists("w:is_scratch_window")
				unlet w:is_scratch_window
				exec "q"
			else
				exec "normal! :Sscratch\<CR>\<C-W>J:resize 13\<CR>"
				let w:is_scratch_window = 1
			endif
		endfunction

		nnoremap <silent> <leader><Tab> :ScratchToggle<CR>

	"}}}
	" Taglist {{{

		nnoremap <F3> :TlistToggle<CR>
		inoremap <F3> <ESC>:TlistToggle<CR>i

		let Tlist_Show_One_File		= 1
		let Tlist_Exit_OnlyWindow	= 1
		let Tlist_Use_Right_Window	= 1
		
	" }}}

" }}}
" Miscellanea --------------------------------------------------------------------------------- {{{
	
	" GTK+-esque tab switching {{{

		nmap		<C-t>		:tabnew<CR>
		nmap		<C-S-Tab>	:tabprevious<CR>
		nmap		<C-Tab>		:tabnext<CR>
		nmap		<C-w>		:q<CR>
		map			<C-S-Tab>	:tabprevious<CR>
		map			<C-Tab>		:tabnext<CR>
		map			<C-w>		:q<CR>
		imap		<C-S-Tab>	<Esc>:tabprevious<CR>i
		imap		<C-Tab>		<Esc>:tabnext<CR>i
		imap		<C-w>		<Esc>:q<CR>
		imap		<C-t>		<Esc>:tabnew<CR>

	" }}}

	" Quick-edit frequent stuff in split 
		nnoremap	<leader>v	<C-w>s<C-w>j:e $MYVIMRC<CR>
		nnoremap	<leader>r	:source $MYVIMRC<CR>
		nnoremap	<leader>t	<C-w>s<C-w>j:e /data/documents/todo.org<CR>

	" Reformat paragraphs
		nnoremap	Q			gqip

	" Save as root
		cmap		w!!			w !sudo tee % >/dev/null

	" Shortcuts for file types
		nnoremap	_c			:set ft=css<CR>
		nnoremap	_h			:set ft=html<CR>
		nnoremap	_o			:set ft=org<CR>
		nnoremap	_p			:set ft=php<CR>
		nnoremap	_pr			:set ft=processing<CR>
		nnoremap	_s			:set ft=sh<CR>

	" Resize splits when the window is resized
		au VimResized * exe "normal! \<c-w>="

	" Compile and run Processing code
	" TODO Make this stuff configurable and move it to a separate plugin
		function! RunProcessing () " {{{
			wa
			let proc_appname=fnamemodify(bufname("%"), ":p:h:t")
			let proc_path=fnamemodify(bufname("%"), ":p:h")
			let native_lib_path="/opt/processing/modes/java/libraries/opengl/library/linux32/"
			let classpath=
				\"\"/opt/processing/java/lib/rt.jar:".
				\"/opt/processing/java/lib/tools.jar:".
				\"/opt/processing/lib/antlr.jar:".
				\"/opt/processing/lib/core.jar:".
				\"/opt/processing/lib/ecj.jar:".
				\"/opt/processing/lib/jna.jar:".
				\"/opt/processing/lib/pde.jar:".
				\"/opt/processing/modes/java/libraries/opengl/library/opengl.jar:".
				\"/opt/processing/modes/java/libraries/opengl/library/jogl.jar:".
				\"/opt/processing/modes/java/libraries/opengl/library/gluegen-rt.jar:".
				\"/data/code/Ani/library/Ani.jar:".
				\".\" "

			exec "! rm " . proc_path . "/*.class"

			exec "! cd " . proc_path .
				\" && /opt/processing/java/bin/javac -classpath ".classpath.
				\" *.java"

			exec "! cd " . proc_path .
				\" && /opt/processing/java/bin/java -cp ".classpath.
				\" -Djava.library.path=".native_lib_path.
				\" processing.core.PApplet ".proc_appname

		endfunction "}}}

		nnoremap <F5> :call RunProcessing()<CR>
		inoremap <F5> <ESC>:call RunProcessing()<CR>
" }}}
