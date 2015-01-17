#!/usr/bin/zsh

typeset -Ag THEME_DEFAULTS
THEME_DEFAULTS=(
	default_fg 'black'
	default_bg 236
	default_icon_bg 234
	default_icon_fg 'white'

	warning_bg 'yellow'
	warning_icon_bg 172
	warning_fg 'black'
	warning_icon_fg 'black'

	critical_bg 'red'
	critical_icon_bg 88
	critical_fg 'white'
	critical_icon_fg 'white'
)

[ $UID -eq 0 ] && prompt_fg='red' || prompt_fg='blue'

typeset -Ag THEME_PROMPT
THEME_PROMPT=(
	shallow_prefix	"${FG[$prompt_fg]}  "
	shallow_prefix_simple " "
	shallow_suffix	" "
	shallow_suffix_simple "  "

	deep_prefix		"${FG[$prompt_fg]}${FX[r+]}  "
	deep_prefix_simple " "
	deep_suffix		"  ${FX[r-]}${CH[AR]}${FX[0]}${FX[b+]}${FG[$prompt_fg]} "
	deep_suffix_simple "  ${CH[ar]} "

	dir_sep			"${FX[b-]}${FG[grey4]} ${CH[ar]} ${FG[$prompt_fg]}${FX[b+]}"
	dir_sep_simple	"  ${CH[ar]} "
	suffix			"${FG[grey4]} ${CH[ar]} ${FX[0]}"
	comp_busy		"${CH[e]}"

	shallow_ssh_user_prefix	"${FG[234]}"
	shallow_ssh_host_prefix " 🔃  ${FG[$prompt_fg]}"
	shallow_ssh_suffix		" ${CH[I]} "

	deep_ssh_user_prefix	"${BG[31]}"
	deep_ssh_host_prefix " 🔃  ${BG[0]}"
	deep_ssh_suffix		" ${CH[I]} "

	git_branch_prefix "${FX[b+]}${FG[232]}"
	git_sha_prefix "${FX[b-]}${FX[i+]}${FG[233]} ("
	git_sha_suffix ")"

	git_default_fg 232
	git_default_ch "${CH[b]}"

	git_untracked_fg 196
	git_untracked_ch '★'

	git_dirty_fg 202
	git_dirty_ch '★'

	git_staged_fg 118
	git_staged_ch '★'

	git_merging_fg 163
	git_mergint_ch '⚡︎'
)
		
typeset -Ag THEME_PROMPT_PATH
THEME_PROMPT_PATH=(
	'/'		'/'
	"$HOME" ${CH[h]}
	"/data" ${CH[d]}
)

typeset -Ag THEME_WIFI
THEME_WIFI=(
	hi_fg 'green'
	mid_fg 'yellow'
	low_fg 'red'
	off_fg 'grey4'

	hi_min 80
	mid_min 50
)

typeset -Ag THEME_BATTERY
THEME_BATTERY=(
	charging_fg 'green'
	full_fg		'green'
	dch_ok_fg	'green'

	dch_warn_fg ${THEME_DEFAULTS[warning_fg]}
	dch_warn_bg ${THEME_DEFAULTS[warning_bg]}
	
	dch_crit_fg ${THEME_DEFAULTS[critical_fg]}
	dch_crit_bg ${THEME_DEFAULTS[critical_bg]}

	notpresent_fg 'grey4'

	ok_min 60
	warn_min 20
)

typeset -Ag THEME_CLOCK
THEME_CLOCK=(
	format "${TMUX_FX[b+]}${FG[white]}%Y. %B %e. ${CH[c]}  %H:%M:%S${TMUX_FX[b-]}"
)

typeset -Ag THEME_VIM_TABLINE
THEME_VIM_TABLINE=(
	
)

# Highlighter config
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

typeset -Ag ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=standout
ZSH_HIGHLIGHT_STYLES[reserved-word]=bold
ZSH_HIGHLIGHT_STYLES[alias]=bold
ZSH_HIGHLIGHT_STYLES[builtin]=bold
ZSH_HIGHLIGHT_STYLES[function]=bold
ZSH_HIGHLIGHT_STYLES[command]=bold
ZSH_HIGHLIGHT_STYLES[precommand]=bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=standout,underline
ZSH_HIGHLIGHT_STYLES[path_approx]=standout,underline
ZSH_HIGHLIGHT_STYLES[globbing]=underline
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=cyan
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=gray
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=gray
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=none

ZSH_HIGHLIGHT_STYLES[bracket-level-1]=none
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=none
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=none
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=none
ZSH_HIGHLIGHT_STYLES[bracket-level-5]=none
ZSH_HIGHLIGHT_STYLES[bracket-level-6]=none

ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=bg=white,fg=black
