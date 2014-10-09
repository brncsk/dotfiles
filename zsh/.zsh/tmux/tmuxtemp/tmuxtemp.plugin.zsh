function acpitemp {
	local DEFAULT_LOW_MAX=50
	local DEFAULT_MID_MAX=85

	local low_max=${ZSH_THEME_TMUXTEMP[low_max]:-$DEFAULT_LOW_MAX}
	local mid_max=${ZSH_THEME_TMUXTEMP[mid_max]:-$DEFAULT_MID_MAX}

	tempdata=`acpi -t | sed -e 's/\(Thermal 0: \|degrees C\|,\)//g'`
	local tempstat=`echo $tempdata | cut -d' ' -f1`
	local tempval=$((`echo $tempdata | cut -d' ' -f2`))
	
	if [[ `i8kfan` != '0 0' ]]; then
		fan_status="$CH[f]  "
	fi

	if [[ $tempval -lt $low_max ]]; then
		severity='default'
	elif [[ $tempval -lt $mid_max ]]; then
		severity='warning'
	else
		severity='critical'
	fi

	render_status_segment $severity "$fan_status$tempval °C"
}
