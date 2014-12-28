function status_segment_sound {
	amixer=$(amixer get Master)
	local vol=$(echo $amixer | grep -o "[0-9]\+%" | head -1 | tr -d '%')
	local st=$(echo $amixer | grep % | cut -f8 -d' ' | tr -d '\[\]')
	local swn=$((1 + (vol / 34)))

	if [[ $st == 'on' ]]; then
		[[ vol -gt 100 ]] && volc=100 || volc=vol;
		color="sblue$(((volc / 10) + 1))"
		caption="$CH[sp]$CH[sw$((1 + (volc / 34)))]  $(printf %3d $vol)%"
	else
		color='grey3'
		caption="$CH[sp]× $FX[i+](on mute)$FX[i-]"
	fi
	
	render_status_segment "" $color " $caption "
}
