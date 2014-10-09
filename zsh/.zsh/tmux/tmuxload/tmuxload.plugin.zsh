# Print current load average {{{

cpu_count=$(cat /proc/cpuinfo | grep processor | wc -l)

function loadavg {
	local DEFAULT_LOW_MAX=.5
	local DEFAULT_MID_MAX=.75

	local load=$(cat /proc/loadavg | cut -d' ' -f1)
	local load_per_cpu=$(($load / $cpu_count))
	local low_max=${THEME_LOAD[low_max]:-$DEFAULT_LOW_MAX}
	local mid_max=${THEME_LOAD[mid_max]:-$DEFAULT_MID_MAX}
	local severity

	if [[ $load_per_cpu -lt $low_max ]]; then
		severity='default'
	elif [[ $load_per_cpu -lt $mid_max ]]; then
		severity='warning'
	else
		severity='critical'
	fi

	render_status_segment $severity $load
} # }}}
