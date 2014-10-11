# Guess terminal type (this clearly does not cover all possible cases but it works for me)
# (Not in use atm.)
function term_type () {
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
			
			ssh_info

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

function ssh_info () {
	[ ! -z $SSH_CONNECTION ] && \
		small_caps "${THEME_PROMPT[ssh_user_before]}${USER}"
		small_caps ${THEME_PROMPT[ssh_host_before]}${HOST}${THEME_PROMPT[ssh_after]}"
}

# Displays git repository information.
function git_prompt_info () {
	DEFAULT_DIRTY_CHAR='*'
	DEFAULT_DIRTY_FG='red'

	ref=$(git symbolic-ref HEAD 2>/dev/null) || return
	sha=$(git rev-parse --short HEAD 2>/dev/null)
	[[ -n $(git status -s --ignore-submodules=dirty 2>/dev/null) ]] && \
		dirty=" $FG[${THEME_PROMPT[git_dirty_fg]:-$DEFAULT_DIRTY_FG}]${THEME_PROMPT[git_dirty_ch]:-$DEFAULT_DIRTY_CHAR}"

	render_status_segment "$THEME_PROMPT[git_bg]" "$THEME_PROMPT[git_fg]" \
		"$CH[b]  ${ref#refs/heads/}@$sha$dirty"
	echo;
}

local return_code="%(?..%?)"

ZLE_RPROMPT_INDENT=0
setopt PROMPT_SUBST

PS1='$(fancy_wd)'$THEME_PROMPT[suffix]
RPS1='$(git_prompt_info) '
