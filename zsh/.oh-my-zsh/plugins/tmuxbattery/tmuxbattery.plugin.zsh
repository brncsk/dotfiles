# A themeable battery indicator {{{

function tmuxbattery {
	local ch=$(acpi | cut -f2 -d',' | tr -cd '[:digit:]')
	local st=$(acpi | cut -f3 -d' ' | tr -d ',' | tr '[A-Z]' '[a-z]')
	local tm=$(acpi | cut -f3 -d',' | tr -cd '[:digit:]:' | cut -b1-5)
	local m=$st

	if [[ $st == 'discharging' ]]; then
		m='dch_ok'

		if [ $ch -lt $ZSH_THEME_TMUXBATTERY[ok_min] ]; then
			m='dch_warn'
		fi
		if [ $ch -lt $ZSH_THEME_TMUXBATTERY[warn_min] ]; then
			m='dch_crit'
		fi
	fi

	if [[ $tm == '' ]]; then
		tm='    ?'
	fi
	
	echo -n $ZSH_THEME_TMUXBATTERY[${m}_before]
	
	printf `CH b`%.0s {0..$((ch/10))}
	if [ $ch -lt 100 ]; then
		printf ' '%.0s {0..$((10 - (ch/10)))}
	fi
	
	if [[ $m != 'full' ]]; then
		echo -n ' '$tm
	fi

	echo -n $ZSH_THEME_TMUXBATTERY[${m}_after]

} # }}}
