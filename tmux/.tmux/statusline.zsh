#!/usr/bin/zsh

[ -n $TMUX ] && () {

	export THEME_BACKEND=tmux
	SEGMENT_DIR=~/.tmux/segments
	SEGMENTS=(loadavg acpitemp sound wifi battery clock)
	
	source ~/.zsh/lib/presentation.lib.zsh
	source ~/.zsh/lib/theme.lib.zsh

	for s in $SEGMENTS; do
		source ~/.tmux/segments/$s/$s.segment.zsh
		status_segment_$s
	done
}
