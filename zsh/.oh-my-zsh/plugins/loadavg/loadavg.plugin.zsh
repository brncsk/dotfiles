# Print current load average {{{

cpu_count=$(cat /proc/cpuinfo | grep processor | wc -l)

function loadavg {

	local load=$(cat /proc/loadavg | cut -d' ' -f1)
	local load_per_cpu=$(($load / $cpu_count))
	local low_max=${ZSH_THEME_LOADAVG[low_max]:-0.50}
	local mid_max=${ZSH_THEME_LOADAVG[mid_max]:-0.75}
	local show_cpuhog=${ZSH_THEME_LOADAVG[show_cpuhog]:-0}
	local loadrange

	if [[ $load_per_cpu -lt $low_max ]] then
		loadrange="low"
	elif [[ $load_per_cpu -lt $mid_max ]] then
		loadrange="mid"
	else
		loadrange="hi"
	fi

	echo -n $ZSH_THEME_LOADAVG[${loadrange}_before]$load

	[[ $loadrange =~ mid\|hi ]] && [[ $show_cpuhog -gt 0 ]] && {
		echo -n $ZSH_THEME_LOADAVG[cpuhog_before]\
				$(
					ps --no-headers -eo "%C [%p] %c" | \
					sort -r -k1 | \
					grep -v migration | \
					head -1 | \
					sed -e 's/\(^ \+[0-9.]\+ \+\| \)//g' \
				)$ZSH_THEME_LOADAVG[cpuhog_after]
	}

	echo -n $ZSH_THEME_LOADAVG[${loadrange}_after]
} # }}}
