#!/usr/bin/zsh

[ -n $TMUX ] && () {
	source ~/.zsh/tmux/presentation.lib.zsh
	source ~/.zsh/tmux/theme.lib.zsh

	. ~/.zsh/tmux/tmuxload/tmuxload.plugin.zsh
	. ~/.zsh/tmux/tmuxtemp/tmuxtemp.plugin.zsh
	. ~/.zsh/tmux/tmuxsound/tmuxsound.plugin.zsh
	. ~/.zsh/tmux/tmuxwifi/tmuxwifi.plugin.zsh
	. ~/.zsh/tmux/tmuxbattery/tmuxbattery.plugin.zsh
	. ~/.zsh/tmux/tmuxclock/tmuxclock.plugin.zsh

	typeset -A _COLORS
	_COLORS=(
		white	255		pink	198
		red		160		orange	208
		yellow	220		green	154
		blue	039		dgreen	34
		
		grey1	237		grey2	239
		grey3	240		grey4	245
		black	0

		sblue1	17	
		sblue2	18
		sblue3	19
		sblue4	20
		sblue5	21
		sblue6	21
		sblue7	33
		sblue8	39
		sblue9	45
		sblue10	51
	);

	FG () { echo -n '#[fg=colour'$_COLORS[$1]']' }
	BG () { echo -n '#[bg=colour'$_COLORS[$1]']' }
	SP () { echo -n ' ' }
	FX () {
		typeset -A fx
		fx=(
			'b+'	'bold'
			'b-'	'nobold'
			'0'		'default'
			'i'		'italics'
		)

		echo -n '#['$fx[$1]']'
	}
	CH () {
		typeset -A ch
		ch=(
			p	'❯'		g	'∓'		# default prompt, git prompt
			h	''		d	''		# home, data
			s	'→'		I	'│'		# separators
			AL	''		AR	''		# \
			Al	''		Ar	''		#  |- bubbles
			al	''		ar	''		# /
			aL  '◀'		aR	'▶'		# path separators
			c	'⌚'		e	'…'		# clock, ellipses
			bc	'▸'		bd	'◂'		# battery charging/discharging
			sp	''					# battery indicator, speaker
			sw1	''		sw2 ''		# sound waves 1-2
			sw3 ''		w1	''		# sound waves 3, wifi 1
			w2	''		w3	''		# wifi 2-3
            pl  '▸'	    ps  '⏸'     # play, pause
		)

		echo -n $ch[$1]
	}

	typeset -Ag ZSH_THEME_LOADAVG
	ZSH_THEME_LOADAVG=(
		show_cpuhog		0
		low_before		`FG grey3; CH Al; BG grey3; FG white; SP`
		low_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		mid_before		`FG yellow; CH Al; BG yellow; FG black; SP`
		mid_after		`SP; FX 0; FG yellow; CH Ar FX 0`

		hi_before		`FG red``CH Al``BG red``FG white; SP`
		hi_after		`SP; FX 0; FG red; CH Ar; FX 0`

		cpuhog_before	`FX b+`
		cpuhog_after	`FX b-`
	)

	typeset -Ag ZSH_THEME_TMUXTEMP
	ZSH_THEME_TMUXTEMP=(
		low_before		`FG grey3; CH Al; BG grey3; FG white; SP`
		low_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		mid_before		`FG yellow; CH Al; BG yellow; FG black; SP`
		mid_after		`SP; FX 0; FG yellow; CH Ar FX 0`

		hi_before		`FG red``CH Al``BG red``FG white; SP`
		hi_after		`SP; FX 0; FG red; CH Ar; FX 0`
	)

	typeset -Ag ZSH_THEME_TMUXCLOCK
	ZSH_THEME_TMUXCLOCK=(
		before		`FG grey3; CH Al; BG grey3; FG white; FX b+; SP`
		after		`SP; FX 0; FG grey3; CH Ar; FX 0`
		format		"%Y. %B %d. `CH c` %H:%M" 
	)

	typeset -Ag ZSH_THEME_TMUXSOUND
	ZSH_THEME_TMUXSOUND=(
		before		`FG grey3; CH Al; BG grey3; FG white; SP`
		after		`SP; FX 0; FG grey3; CH Ar; FX 0`
	)

	typeset -Ag ZSH_THEME_TMUXWIFI
	ZSH_THEME_TMUXWIFI=(
		hi_before		`FG grey3; CH Al; BG grey3; FG dgreen; SP`
		hi_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		mid_before		`FG grey3; CH Al; BG grey3; FG yellow; SP`
		mid_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		low_before		`FG grey3; CH Al; BG grey3; FG red; SP`
		low_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		off_before		`FG grey3; CH Al; BG grey3; FG grey1; SP`
		off_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		hi_min		80
		mid_min		50
	)

	typeset -Ag ZSH_THEME_TMUXBATTERY
	ZSH_THEME_TMUXBATTERY=(
		full_before			`FG grey3; CH Al; BG grey3; FG green; SP`
		full_after			`SP; FX 0; FG grey3; CH Ar; FX 0`

		charging_before		`FG grey3; CH Al; BG grey3; FG green; SP`
		charging_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		dch_ok_before		`FG grey3; CH Al; BG grey3; FG dgreen; SP`
		dch_ok_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		dch_warn_before		`FG grey3; CH Al; BG grey3; FG yellow; SP`
		dch_warn_after		`SP; FX 0; FG grey3; CH Ar; FX 0`

		dch_crit_before		`FG red``CH Al``BG red``FG white; SP`
		dch_crit_after		`SP; FX 0; FG red; CH Ar; FX 0`

		unknown_before		`FG grey3; CH Al; BG grey3; FG white; SP`
		unknown_after		`SP; FX 0; FG grey3; CH Ar; FX 0`
		
		notpresent_before	`FG grey3; CH Al; BG grey3; FG grey4; FX i; SP`
		notpresent_after	`SP; FX 0; FG grey3; CH Ar; FX 0`

		ok_min				60
		warn_min			20
	)

	tmuxsound
	tmuxwifi
	tmuxbattery
	loadavg
	acpitemp
	tmuxclock
}
