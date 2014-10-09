# A themeable battery indicator {{{

function tmuxbattery {
	local ch=$(acpi -b | cut -f2 -d',' | tr -cd '[:digit:]')
	local st=$(acpi -b | cut -f3 -d' ' | tr -d ',' | tr '[A-Z]' '[a-z]')
	local tm=$(acpi -b | cut -f3 -d',' | tr -cd '[:digit:]:' | cut -b1-5)
	local m=$st
    local chr

	if [[ $ch == '' ]]; then
		echo -n $ZSH_THEME_TMUXBATTERY[notpresent_before]
		echo -n "(Not present.)"
		echo -n $ZSH_THEME_TMUXBATTERY[notpresent_after]
        chr=`CH bd`
	else
        chr="🔌 "
		if [[ $st == 'discharging' ]]; then
            chr=
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

		echo -n $chr" "
	
		if [[ $ch -lt 10 ]]; then
			echo -n ""
		else
			echo -n ""
		fi

		printf "%.0s" {0..$(((ch/10) - 1))}
		
		if [ $ch -lt 90 ]; then
			printf ''%.0s {0..$((10 - (ch/10)))}
		fi

		if [ $ch -lt 100 ]; then
			echo -n ""
		else
			echo -n ""	
		fi
		
		if [[ $m != 'full' ]]; then
			echo -n ' '$tm
		fi

		echo -n $ZSH_THEME_TMUXBATTERY[${m}_after]
	fi

} # }}}
