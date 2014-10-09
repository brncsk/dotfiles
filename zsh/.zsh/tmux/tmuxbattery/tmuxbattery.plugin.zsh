function tmuxbattery {
	acpi=$(acpi -b)
	local ch=$(echo $acpi | cut -f2 -d',' | tr -cd '[:digit:]')
	local st=$(echo $acpi | cut -f3 -d' ' | tr -d ',' | tr '[A-Z]' '[a-z]')
	local tm=$(echo $acpi | cut -f3 -d',' | tr -cd '[:digit:]:' | cut -b1-5)
	local m=$st
    local charging
	local icon
	local bat_status

	if [[ $ch == '' ]]; then
		icon='(Not present.)'
		bat_status='notpresent'
        charging=$CH[bd]
	else
		bat_status='charging'
        charging=$CH[ch]

		if [[ $st == 'discharging' ]]; then
			charging=
			bat_status='dch_ok'

			if [ $ch -lt $THEME_BATTERY[ok_min] ]; then
				bat_status='dch_warn'
			fi
			if [ $ch -lt $THEME_BATTERY[warn_min] ]; then
				bat_status='dch_crit'
			fi
		fi

		if [[ $tm == '' ]]; then
			tm='?'
		fi

		if [[ $ch -lt 10 ]]; then
			icon=$CH[bl]
		else
			icon=$CH[bL]
		fi

		icon+=$(printf "$CH[bM]%.0s" {0..$(((ch/10) - 1))})
		
		if [ $ch -lt 90 ]; then
			icon+=$(printf "$CH[bm]%.0s" {0..$((10 - (ch/10)))})
		fi

		if [ $ch -lt 100 ]; then
			icon+=$CH[br]
		else
			icon+=$CH[bR]
		fi
	
	fi
		
	render_status_segment "$THEME_BATTERY[${bat_status}_bg]" "$THEME_BATTERY[${bat_status}_fg]" \
		" $charging $icon $tm "
}
