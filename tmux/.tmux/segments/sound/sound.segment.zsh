function status_segment_sound {
	amixer=$(amixer get Master)
	local vol=$(echo $amixer | grep -o "[0-9]\+%" | head -1 | tr -d '%')
	local st=$(echo $amixer | grep % | cut -f8 -d' ' | tr -d '\[\]')
	local swn=$((1 + (vol / 34)))

	if [[ $st == 'on' ]]; then
		[[ vol -gt 100 ]] && volc=100 || volc=vol;
		color="sblue$(((volc / 10)))"
		caption_1="$CH[sp]$CH[sw$((1 + (volc / 34)))] "
		caption_2="$FX[b+]$FG[232]$(printf %3d $vol)%$FX[b-]"
	else
		color='grey3'
		caption_1="$CH[sp]×"
		caption_2="$FX[i+](on mute)$FX[i-]"
	fi
	
	render_status_segment_split "$color" "$caption_1" "$caption_2"
}
