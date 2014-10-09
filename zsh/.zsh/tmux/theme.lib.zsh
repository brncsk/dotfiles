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
