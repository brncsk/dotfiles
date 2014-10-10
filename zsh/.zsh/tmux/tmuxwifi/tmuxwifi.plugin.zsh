function tmuxwifi {
	local DEFAULT_HI_MIN=80
	local DEFAULT_MID_MIN=50

	local dev=`iw dev | grep -oP "(?<=Interface )([a-z0-9]+)"`
	
	integer qual=$((`iwconfig $dev \
		| grep Quality \
		| sed -e 's/^ \+//' \
		| cut -f2 -d' ' \
		| tr -dc '[:digit:]/'`.0 * 100 ))
	local qn=$((1 + (qual / 34)))
	local m='hi'
	local essid=$(iwconfig $dev | grep ESSID | cut -f2 -d':' | tr -d '"')	

	if [ $qual -lt ${THEME_WIFI[hi_min]:-$DEFAULT_HI_MIN} ]; then m='mid'; fi
	if [ $qual -lt ${THEME_WIFI[mid_min]:-$DEFAULT_MID_MIN} ]; then m='low'; fi

	if [[ $essid != 'off/any' ]]; then
		caption="$CH[w$qn] $(printf %3d $qual)% [$essid]"
	else
		m='off'
		caption="$CH[w3] $TMUX_FX[i+](off)$TMUX_FX[i-]"
	fi

	render_status_segment "" "$THEME_WIFI[${m}_fg]" " $caption "
}
