#!/usr/bin/zsh

typeset -Ag THEME_DEFAULTS
THEME_DEFAULTS=(
	default_fg 'white'
	default_bg 'grey3'

	warning_bg 'yellow'
	warning_fg 'black'

	critical_bg 'red'
	critical_fg 'white'
)

typeset -Ag THEME_PROMPT
THEME_PROMPT=(
	shallow_before	"$FG[blue]  "
	shallow_after	" "

	deep_before		"$FG[blue]$FX[r+]  "
	deep_after		"  $FX[r-]$CH[AR]$FX[0]$FX[b+]$FG[blue] "

	dir_sep			"$FX[b-]$FG[grey4] $CH[ar] $FG[blue]$FX[b+]"
	suffix			"$FG[grey4] $CH[ar] $FX[0]"
	busy_indicator	"$FG[grey4]$CH[e]$FX[0]"

	git_fg	'grey4'
	git_bg	'grey1'
	git_dirty_ch '*'
)
		
typeset -Ag THEME_PROMPT_PATH
THEME_PROMPT_PATH=(
	'/'		'/'
	"$HOME" $CH[h]
	"/data" $CH[d]
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

	dch_warn_fg $THEME_DEFAULTS[warning_fg]
	dch_warn_bg $THEME_DEFAULTS[warning_bg]
	
	dch_crit_fg $THEME_DEFAULTS[critical_fg]
	dch_crit_bg $THEME_DEFAULTS[critical_bg]

	notpresent_fg 'grey4'

	ok_min 60
	warn_min 20
)

typeset -Ag THEME_CLOCK
THEME_CLOCK=(
	format "${TMUX_FX[b+]}%Y. %B %e. ${CH[c]}  %H:%M${TMUX_FX[b-]}"
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
