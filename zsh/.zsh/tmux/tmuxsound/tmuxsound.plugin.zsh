function tmuxsound {
	amixer=$(amixer get Master)
	local vol=$(echo $amixer | grep -o "[0-9]\+%" | head -1 | tr -d '%')
	local st=$(echo $amixer | grep % | cut -f8 -d' ' | tr -d '\[\]')
	local swn=$((1 + (vol / 34)))

	if [[ $st == 'on' ]]; then
		color="sblue$((vol / 10))"
		caption="$CH[sp]$CH[sw$swn]  $(printf %3d $vol)%"
	else
		color='grey4'
		caption="$CH[sp]× $TMUX_FX[i+](on mute)$TMUX_FX[i-]"
	fi
	
	render_status_segment "" $color " $caption "
}
