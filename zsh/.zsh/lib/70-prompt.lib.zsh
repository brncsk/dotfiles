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
	local cwd p pt m simple

	[[ $PWD == '/' ]] && cwd=('/') || {
		cwd="${PWD:gs/ />}"
		cwd=(/ "${(s:/:)${cwd[2,-1]}}")
	}

	[[ $1 == true ]] && simple=_simple || simple=

	for pt in ${(Ok)THEME_PROMPT_PATH}; do
		[[ $pt == '/' ]] && p=("/") || p=(/ "${(s:/:)${pt[2,-1]}}")

		[[ ${cwd[1,${#p}]} == $p ]] && {
			[[ $cwd == $p ]] && m=shallow || m=deep

			echo -n "$THEME_PROMPT[${m}_prefix${simple}]"
			
			[[ $simple == '' ]] && ssh_info

			echo -n "$THEME_PROMPT_PATH[$pt]"

			echo -n "$THEME_PROMPT[${m}_suffix${simple}]"

			cwd=$cwd[${#p}+1,-1]
			
			break
		}
	done

		cwd="${cwd// /${THEME_PROMPT[dir_sep${simple}]}}"
		cwd="${cwd//>/ }"

	[[ ${#cwd} -gt 0 ]] && echo -n $cwd
}

function ssh_info () {
	[ ! -z ${SSH_CONNECTION} ] && {
		small_caps "${THEME_PROMPT[ssh_user_prefix]}${USER}"
		small_caps "${THEME_PROMPT[ssh_host_prefix]}${HOST}${THEME_PROMPT[ssh_suffix]}"
	}
}

# Displays git repository information.
function git_prompt_info () {
	ref=$(git symbolic-ref HEAD 2>/dev/null) || return
	sha=$(git rev-parse --short HEAD 2>/dev/null)

	render_status_segment_split "$(parse_git_status) " \
		"${THEME_PROMPT[git_branch_prefix]}${ref#refs/heads/}${THEME_PROMPT[git_sha_prefix]}$sha${THEME_PROMPT[git_sha_suffix]}"
	echo;
}

# Parses git status
function parse_git_status () {
	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	local s=''

	[[ -n $(git ls-files --other --exclude-standard 2>/dev/null) ]] && \
		s="${s}${FG[${THEME_PROMPT[git_untracked_fg]}]}${THEME_PROMPT[git_untracked_ch]}"

	[[ -n $(git status -s --ignore-submodules=dirty 2>/dev/null) ]] && \
		s="${s}${FG[${THEME_PROMPT[git_dirty_fg]}]}${THEME_PROMPT[git_dirty_ch]}"

	[[ -n $(git diff --cached --quiet 2>/dev/null) ]] && \
		s="${s}${FG[${THEME_PROMPT[git_dirty_fg]}]}${THEME_PROMPT[git_staged_ch]}"

	[[ -n $GIT_DIR ]] && [[ -r $GIT_DIR/MERGE_HEAD ]] && \
		s="${s}${FG[${THEME_PROMPT[git_merging_fg]}]}${THEME_PROMPT[git_merging_ch]}"

	[[ $s == '' ]] && { echo -n ${THEME_PROMPT[git_default_ch]} } || { echo -n ${s} }
}

function precmd () {
	print -Pn '\ek'$(fancy_wd true)'\e\\'
}

local return_code="%(?..%?)"

ZLE_RPROMPT_INDENT=0
setopt PROMPT_SUBST

PS1='$(fancy_wd)'$THEME_PROMPT[suffix]
RPS1='$(git_prompt_info) '
