#!/usr/bin/zsh

[ -n $TMUX ] && () {

	export THEME_BACKEND=tmux
	SEGMENT_DIR=~/.tmux/segments
	SEGMENTS=(sound wifi battery loadavg acpitemp clock)
	
	source ~/.zsh/lib/50-presentation.lib.zsh
	source ~/.zsh/lib/60-theme.lib.zsh

	for s in $SEGMENTS; do
		source ~/.tmux/segments/$s/$s.segment.zsh
		status_segment_$s
	done
}
