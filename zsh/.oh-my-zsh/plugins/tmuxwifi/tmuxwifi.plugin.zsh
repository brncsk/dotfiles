# A themeable wifi indicator {{{

function tmuxwifi {
	local dev=`iw dev | grep -oP "(?<=Interface )([a-z0-9]+)"`
	
	integer qual=$((`iwconfig $dev \
		| grep Quality \
		| sed -e 's/^ \+//' \
		| cut -f2 -d' ' \
		| tr -dc '[:digit:]/'`.0 * 100 ))
	local qn=$((1 + (qual / 34)))
	local m='hi'
	local essid=$(iwconfig $dev | grep ESSID | cut -f2 -d':' | tr -d '"')
	
	if [ $qual -lt $ZSH_THEME_TMUXWIFI[hi_min] ]; then m='mid'; fi
	if [ $qual -lt $ZSH_THEME_TMUXWIFI[mid_min] ]; then m='low'; fi
	if [[ $essid == 'off/any' ]]; then m='off'; fi

	echo -n $ZSH_THEME_TMUXWIFI[${m}_before]

	if [[ $essid != 'off/any' ]]; then
		echo -n `CH w$qn`' '
		printf %3d $qual
		echo -n %
		echo -n " [$essid]"
	else
		echo -n `CH w3`' (off)'
	fi

	echo -n $ZSH_THEME_TMUXWIFI[${m}_after]

} # }}}
