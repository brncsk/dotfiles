#!/usr/bin/zsh

typeset -Ag CH NAMED_COLORS FX FG BG TMUX_FX TMUX_FG TMUX_BG

CH=(
	p	'❯'					# Default prompt character
	g	'∓'					# Git prompt character

	h	''					# Home
	d	''					# Data

	e	'…'					# Ellipses

	s	'→'		I	'│'		# Various separators
	aL  '◀'		aR	'▶'		# Various separators

	AL	''		AR	''		# \
	Al	''		Ar	''		#  |- Segment dividers 
	al	''		ar	''		# /

	sp	''					# \
	sw1	''		sw2 ''		#  |- Sound indicator
	sw3 ''					# /
	pl  '▸'					# Play
	ps  '⏸'					# Pause
	
	w1	''					# \
	w2	''					#  |- WiFi indicator
	w3	''					# /
	
	ch	'🔌'					# Charger
	bl	''		bL ''		# \
	bm	''		bM ''		# |- Battery indicator
	br	''		bR ''		# /
	
	f	''					# Fan
	c	'⌚'					# Clock
)

NAMED_COLORS=(
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

FX=(
	0  "%{[00m%}"
	b+ "%{[01m%}" b- "%{[22m%}"
	i+ "%{[03m%}" i- "%{[23m%}"
	u+ "%{[04m%}" u- "%{[24m%}"
	l+ "%{[05m%}" l- "%{[25m%}"
	r+ "%{[07m%}" r- "%{[27m%}"
)

TMUX_FX=(
	0  "#[default]"
	b+ "#[bold]"       b- "#[nobold]"
	i+ "#[italics]"    i- "#[noitalics]"
	u+ "#[underscore]" u- "#[nounderscore]"
	l+ "#[blink]"      l- "#[noblink]"
	r+ "#[reverse]"    r- "#[noreverse]"
)

for i in {0..255}; do
    FG[$i]="%{[38;5;${i}m%}"
	TMUX_FG[$i]="#[fg=colour$i]"

    BG[$i]="%{[48;5;${i}m%}"
	TMUX_BG[$i]="#[bg=colour$i]"
done

for nc in ${(@k)NAMED_COLORS}; do
	FG[$nc]=$FG[$NAMED_COLORS[$nc]]
	TMUX_FG[$nc]=$TMUX_FG[$NAMED_COLORS[$nc]]

	k
	BG[$nc]=$BG[$NAMED_COLORS[$nc]]
	TMUX_BG[$nc]=$TMUX_BG[$NAMED_COLORS[$nc]]
done

function render_status_segment () {
	if [ $# -eq 1 ]; then
		caption=$1
	elif [ $# -eq 2 ]; then
		c_fg=$THEME_DEFAULTS[${1}_fg]
		c_bg=$THEME_DEFAULTS[${1}_bg]
		caption=$2
	elif [ $# -eq 3 ]; then
		c_fg=$2
		c_bg=$1
		caption=$3
	fi

	[ -z $c_fg ] && c_fg=$THEME_DEFAULTS[default_fg]
	[ -z $c_bg ] && c_bg=$THEME_DEFAULTS[default_bg]

	echo -n "${TMUX_FG[$c_bg]}${CH[Al]}${TMUX_BG[$c_bg]}${TMUX_FG[$c_fg]}"
	echo -n "${caption}"
	echo -n "${TMUX_FX[0]}${TMUX_FG[$c_bg]}${CH[Ar]}${TMUX_FX[0]}"
}
