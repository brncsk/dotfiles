" M
" .vimrc
" Author: Ádám Barancsuk <adam.barancsuk@gmail.com>
" Source: .vimrc by Steve Losh <steve@stevelosh.com> [http://bitbucket.org/sjl/dotfiles/src/tip/vim]

" Preamble ------------------------------------------------------------------------------------ {{{

	let g:Powerline_symbols="fancy"
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
	set statusline	+=)								" )
	set statusline	+=\ (L\ %l\/%L,\ C\ %3c)		" Line/col position/count

" }}}
" Tabline ------------------------------------------------------------------------------------- {{{
	
	if exists("+showtabline")
		function! MyTabLine()
			let s = '%#TabLineBorder#'
			let wn = ''
			let t = tabpagenr()
			let i = 1
			while i <= tabpagenr('$')
				let buflist = tabpagebuflist(i)
				let winnr = tabpagewinnr(i)
				let s .= '%' . i . 'T'
				let s .= '%#TabLine' . (i == t ? 'Sel' : '') . 'Border#'
				let s .= '%#TabLine' . (i == t ? 'Sel' : '' ).'Bg# '
				let wn = tabpagewinnr(i,'$')

				if tabpagewinnr(i,'$') > 1
					let s .= '.'
					let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
				end

				let bufnr = buflist[winnr - 1]
				let file = bufname(bufnr)
				let buftype = getbufvar(bufnr, 'buftype')
				if buftype == 'nofile'
					if file =~ '\/.'
						let file = substitute(file, '.*\/\ze.', '', '')
					endif
				else
					let file = fnamemodify(file, ':p:t')
				endif
				if file == ''
					let file = '%#TabLine' . (i == t ? 'Sel' : '') .  'NoName#[Névtelen]'
				endif
				let s .= file
				let s .= (getbufvar(buflist[winnr - 1], "&mod")?'%#TabLine' . (i == t ? 'Sel' : '') . 'Modified#*':'')
				let s .= (i == t ? ('%#TabLineSelClose#%' . i . 'X ×%X') : '')
				let s .= ' %#TabLine' . (i == t ? 'Sel' : '') . 'Border# '
				let i = i + 1
			endwhile
			return s
		endfunction
		set stal=2
		set tabline=%!MyTabLine()
	endif
	
	hi TabLineSelBorder ctermfg=232 ctermbg=242
	hi TabLineSelBg term=bold cterm=bold ctermfg=252 ctermbg=232
	hi TabLineSelModified term=bold cterm=bold ctermfg=1 ctermbg=232
	hi TabLineSelNoName term=bold,italic cterm=bold,italic ctermfg=252 ctermbg=232
	hi TabLineSelClose term=NONE ctermfg=249
	hi TabLineModified term=bold cterm=bold ctermfg=1 ctermbg=240
	hi TabLineBorder ctermfg=240 ctermbg=242
	hi TabLineNoName term=italic cterm=italic ctermfg=248 ctermbg=240
	hi TabLineBg ctermfg=248 ctermbg=240

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

	" Powerline {{{
	

	" }}}

	" Pastebin {{{

		nnoremap <leader>p call PasteBin

	" }}}

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
	
		:imap <S-CR> <C-y>,

	" }}}
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

	" }}}
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
		nmap		[1;5D		:tabprevious<CR>
		nmap		[1;5C		:tabnext<CR>
		nmap		<C-w>		:q<CR>
		map			[1;5D		:tabprevious<CR>
		map			[1;5C	:tabnext<CR>
		map			<C-w>		:q<CR>
		imap		[1;5D		<Esc>:tabprevious<CR>i
		imap		[1;5C	<Esc>:tabnext<CR>i
		imap		<C-w>		<Esc>:q<CR>
		imap		<C-t>		<Esc>:tabnew<CR>

	" }}}

	" Python

		if !exists("autocommands_loaded")
			let autocommands_loaded = 1
			autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vimrc
		endif

	" Vala

		autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
		au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

	" NOOOOO
		nnoremap	:W			:w

	" Quick-edit frequent stuff in split 
		nnoremap	<leader>v	<C-w>s<C-w>j:e $MYVIMRC<CR>
		nnoremap	<leader>r	:source $MYVIMRC<CR>

	" Pasting from the OS clipboard
		nnoremap	<leader>p	"+p
		nnoremap	<leader>P	"+P

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

	" Save next diary entry
		function! SaveDiary () " {{{

			let path="/data/documents/diary/"
			let date=strftime("%Y-%m-%d")

			w path.date.".txt" 

		endfunction "}}}

		nnoremap :wd<CR> :call SaveDiary()<CR>

" }}}
