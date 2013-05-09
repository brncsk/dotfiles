# A themeable clock for tmux status lines {{{

function tmuxclock {
	echo -n $ZSH_THEME_TMUXCLOCK[before]
	echo -n `date +$ZSH_THEME_TMUXCLOCK[format]`
	echo -n $ZSH_THEME_TMUXCLOCK[after]

} # }}}
