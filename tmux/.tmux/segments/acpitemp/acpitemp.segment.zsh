function status_segment_acpitemp {
	local DEFAULT_LOW_MAX=70
	local DEFAULT_MID_MAX=85

	local low_max=${THEME_TEMP[low_max]:-$DEFAULT_LOW_MAX}
	local mid_max=${THEME_TEMP[mid_max]:-$DEFAULT_MID_MAX}

	local tempdata="$(acpi -t | sed -e 's/\(Thermal 0: \|degrees C\|,\)//g')"
	local tempstat=`echo "${tempdata}" | cut -d' ' -f1`
	local tempval=$(printf '%d' $(echo "${tempdata}" | cut -d' ' -f2))
	
	[[ $(i8kfan) == '0 0' ]] || fan_status="$CH[f] "

	if [ ${tempval} -lt ${low_max} ]; then
		severity='default';
	elif [ ${tempval} -lt ${mid_max} ]; then
		severity='warning';
	else
		severity='critical'
	fi

	tempval="${tempval} °C"

	[[ $fan_status ]] &&
		render_status_segment_split "$severity" "$fan_status" "$tempval" ||
		render_status_segment "$severity" "$tempval"
}
