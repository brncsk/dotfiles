# Guess terminal type (this clearly does not cover all possible cases but it works for me)
# (Not in use atm.)
function term_type {
	([[ `tty` == *tty* ]] && echo 'tty') || \
	([[ `tty` == *pts* && $TERM == *screen* ]] && echo 'xscreen') || \
	([[ $TERM == *screen* ]] && echo 'screen') || \
	([[ $TERM == *xterm* ]] && echo 'xterm') || \
	([[ $TERM == *vte* ]] && echo 'vte') || \
	echo 'unknown'
}

# Fancy up the current working directory for display
function fancy_wd () {
	local cwd p pt m

	[[ $PWD == '/' ]] && cwd=('/') || {
		cwd=${PWD:gs/ />}
		cwd=(/ "${(s:/:)${cwd[2,-1]}}")
	}

	for pt in ${(Ok)THEME_PROMPT_PATH}; do
		[[ $pt == '/' ]] && p=("/") || p=(/ "${(s:/:)${pt[2,-1]}}")

		[[ ${cwd[1,${#p}]} == $p ]] && {
			[[ $cwd == $p ]] && m=shallow || m=deep
			
			echo -n $THEME_PROMPT[${m}_before]
			echo -n $THEME_PROMPT_PATH[$pt]
			echo -n $THEME_PROMPT[${m}_after]

			cwd=$cwd[${#p}+1,-1]
			
			break
		}
	done

	cwd=${cwd// /$THEME_PROMPT[dir_sep]}
	cwd=${cwd//>/ }

	[[ ${#cwd} -gt 0 ]] && echo -n $cwd
}

local return_code="%(?..%?)"

ZLE_RPROMPT_INDENT=0
setopt PROMPT_SUBST

PS1='$(fancy_wd)'$THEME_PROMPT[suffix]
RPS1="$return_code"'$(git_prompt_info)'
