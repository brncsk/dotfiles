typeset -Ag _COLORS _ANSIFX _CHARS ZSH_THEME_PATH_CHARS ZSH_THEME_PATH_STYLE ZSH_THEME_LOADAVG

# Guess terminal type (this clearly does not cover all possible cases but it works for me) {{{
function term_type {
	([[ `tty` == *tty* ]] && echo 'tty') || \
	([[ `tty` == *pts* && $TERM == *screen* ]] && echo 'xscreen') || \
	([[ $TERM == *screen* ]] && echo 'screen') || \
	([[ $TERM == *xterm* ]] && echo 'xterm') || \
	([[ $TERM == *vte* ]] && echo 'vte') || \
	echo 'unknown'
} # }}}

# Setup terminal dependent stuff {{{
function set_term_dependent_stuff {
	local -A color_names
	local _term_type=${FORCE_TERM_TYPE:-$(term_type)}
	local _ssh_pathinfo

	_ANSIFX=(
		0	$reset_color
		b+	$FX[bold]
		b-	$FX[no-bold]
		r+	$FX[reverse]
		r-	$FX[no-reverse]
	)

	case $_term_type in
		tty)
			_COLORS=(
				pink "$fg[magenta]"	
				orange "$fg[yellow]"
				green "$fg[green]"
				blue "$fg[blue]"
				grey "$fg[white]"
				darkgrey "$fg[gray]"
			)
			
			_CHARS=(
				p '>'	g '+'	# prompt	git
				h '~'	d 'D'	# home		data
				s '→'	Al ''	# path sep	bubble l
				Ar ''	al '<'	# bubble r	item sep
				I '|'	ar '>'	# item sep	item sep
				c ''			# clock
			)
			
			ZSH_THEME_GIT_PROMPT_PREFIX=' ('
			ZSH_THEME_GIT_PROMPT_SUFFIX=')'
			ZSH_THEME_GIT_TEXT_CALLBACK=
		;;

		screen|xterm|xscreen|vte)
			_COLORS=(
				black   0
				white	255		pink	198
				red		160		orange	208
				yellow	220		green	154
				blue	039
				
				grey1	237		grey2	239
				grey3	240		grey4	245
			);

			_COLORS+=(
				base	$_COLORS[grey4]
				user	$_COLORS[green]
				host	$_COLORS[blue]
				path	$_COLORS[blue]
				git_bg	$_COLORS[pink]
			)

			_CHARS=(
				p	'❯'		g	'∓'		# prompt		git
				h	'⮇'		d	'⮆'		# home			data
				s	'→'		I	'│'		# separators
				AL	'⮂'		AR	'⮀'		# \
				Al	'⮄'		Ar	'⮅'		# | bubbles
				al	'⮃'		ar	'⮁'		# /
				aL  '◀'		aR	'▶'
				c	'⌚'		e	'…'		# clock			ellipses
				b	'⭠'
			)
	
			ZSH_THEME_GIT_PROMPT_PREFIX=`SP; FG pink; CH Al; BG pink; FG white; SP; CH b; SP;`
			ZSH_THEME_GIT_PROMPT_SUFFIX=`FX 0; FG pink; CH Ar; FX 0`
			ZSH_THEME_GIT_TEXT_CALLBACK=small_caps

		;;
	esac

	ZSH_THEME_LOADAVG=(
		show_cpuhog		0
		low_before		`FG grey3; CH Al; BG grey3; FG grey1; SP`
		low_after		`SP; FX 0; FG grey3; CH Ar`

		mid_before		`FG yellow; CH Al; BG yellow; FG grey1; SP`
		mid_after		`SP; FX 0; FG yellow; CH Ar`

		hi_before		`FG red``CH Al``BG red``FG white; SP`
		hi_after		`SP; FX 0; FG red; CH Ar`

		cpuhog_before	`FX b+`
		cpuhog_after	`FX b-`
	)

	ZSH_THEME_GIT_PROMPT_DIRTY=
	ZSH_THEME_GIT_PROMPT_CLEAN=

	ZSH_THEME_PATH_CHARS=(
		"$HOME"	`CH h`
		"/data"	`CH d`
		"/"		'/'
	)

	[[ ! -z $SSH_CONNECTION ]] && _ssh_pathinfo='%M : ' || _ssh_pathinfo=' '

	ZSH_THEME_PATH_STYLE=(
		inactive_before	"`FG path; SP`$_ssh_pathinfo"
		inactive_after	" "
		active_before	"`FG path; FX r+; SP`$_ssh_pathinfo"
		active_after	"`SP; SP; FX r-; CH AR; FX 0; FX b+; FG path; SP`"
		dir_separator	"`FX b-; FG base; SP; CH ar; SP; FG blue; FX b+`"
	)
		
	ZSH_THEME_COMPLETION_WAITING_MSG=${_FG[$_COLORS[grey4]]}$_CHARS[e]$_ANSIFX[0]

} # }}}

# Formatting shortcuts {{{
function FG () { echo -n "%{$FG[$_COLORS[$1]]%}" }
function BG () { echo -n "%{$BG[$_COLORS[$1]]%}" }
function FX () { echo -n "%{$_ANSIFX[$1]%}" }
function CH () { echo -n "$_CHARS[$1]" }
function SP () { echo -n ' ' } # }}}

# Replace name of certain directories with unicode characters {{{
function sane_cwd () {
	local cwd p pt m

	[[ $PWD == '/' ]] && cwd=('/') || {
		cwd=${PWD:gs/ />}
		cwd=(/ "${(s:/:)${cwd[2,-1]}}")
	}

	for pt in ${(Ok)ZSH_THEME_PATH_CHARS}; do
		[[ $pt == '/' ]] && p=("/") || p=(/ "${(s:/:)${pt[2,-1]}}")

		[[ ${cwd[1,${#p}]} == $p ]] && {
			[[ $cwd == $p ]] && m=inactive || m=active
			
			echo -n $ZSH_THEME_PATH_STYLE[${m}_before]
			echo -n $ZSH_THEME_PATH_CHARS[$pt]
			echo -n $ZSH_THEME_PATH_STYLE[${m}_after]

			cwd=$cwd[${#p}+1,-1]
			
			break
		}
	done

	cwd=${cwd// /$ZSH_THEME_PATH_STYLE[dir_separator]}
	cwd=${cwd//>/ }

	[[ ${#cwd} -gt 0 ]] && echo -n $cwd
} # }}}

function set_title () {
	local cwd p pt t=''
	
	[[ $PWD == '/' ]] && cwd=('/') || cwd=(/ "${(s:/:)${PWD[2,-1]}}")

	for pt in ${(Ok)ZSH_THEME_PATH_CHARS}; do
		[[ $pt == '/' ]] && p=("/") || p=(/ "${(s:/:)${pt[2,-1]}}")

		[[ ${cwd[1,${#p}]} == $p ]] && {
			t+=$ZSH_THEME_PATH_CHARS[$pt]
			[[ ($cwd != $p) ]] && [[ $pt != '/' ]] && t+=' '`CH aR`' '

			cwd=$cwd[${#p}+1,-1]
			
			break
		}
	done

	[[ ${#cwd} -gt 0 ]] && t+=${cwd// / `CH aR` }

	tmux rename-window $t
}

ZSH_THEME_RETVAL_PREFIX=`SP; FG yellow; CH Al; BG yellow; FG grey1; SP;`
ZSH_THEME_RETVAL_SUFFIX=`SP; FX 0; FG yellow; CH Ar; FX 0`

local return_code="%(?..$ZSH_THEME_RETVAL_PREFIX%? ↵$ZSH_THEME_RETVAL_SUFFIX)"

set_term_dependent_stuff;

PS1='$(set_title)$(sane_cwd)'`FX b-SP; FG base; SP; CH ar; FX 0; SP`
RPS1=$return_code'$(git_prompt_info)'
