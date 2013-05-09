# A themeable sound indicator {{{

function tmuxsound {
	local vol=$(amixer get Master | grep % | cut -f6 -d' ' | tr -cd '[:digit:]')
	local st=$(amixer get Master | grep % | cut -f8 -d' ' | tr -d '\[\]')
	local swn=$((1 + (vol / 34)))

	local mpris="$(~/.oh-my-zsh/plugins/tmuxsound/mpris2.py)"


	if [[ $mpris == '' ]]; then mpris=$(mocp -i); fi

    if [[ $mpris != '' ]]; then
        local artist="$(echo $mpris | grep Artist | cut -f2 -d':')"
        local title="$(echo $mpris | grep SongTitle | cut -f2 -d':')"
        local plst="$(echo $mpris | grep State | cut -f2 -d':')"
    fi

	echo -n $ZSH_THEME_TMUXSOUND[before]

	if [[ $st == 'on' ]]; then
		echo -n `FG sblue$((vol / 10))`
		echo -n `CH sp; CH sw$swn;`' '
		echo -n ' '
		printf %3d $vol
        echo -n %
	else
		echo -n `FG sblue0`
		echo -n `CH sp;`'×     -'
	fi
	if [[ $mpris != '' ]]; then
		echo -n `FG grey4`
		if [[ $plst =~ 'PLAY' ]]; then
			plsym=`CH aR`
		else
			plsym=`CH ps`
		fi
		pltxt="$artist –$title"

		if [[ ${#pltxt} > 25 ]]; then
			if [[ ${#artist} -gt 9 ]]; then
				artist=${artist:1:8}`CH e`
			fi
			if [[ ${#title} -gt 13 ]]; then
				title=${title:1:13}`CH e`
			fi
			pltxt="$artist – $title"
		fi

		echo -n " `CH I` $plsym $pltxt"
	fi

	echo -n $ZSH_THEME_TMUXSOUND[after]

} # }}}
