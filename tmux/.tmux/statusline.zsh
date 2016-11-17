#!/bin/zsh

[ -n $TMUX ] && () {

	SEGMENT_DIR=~/.tmux/segments
	SEGMENTS=(sound clock)
	
	export THEME_BACKEND=tmux
	source ~/.zsh/lib/50-presentation.lib.zsh
	source ~/.zsh/lib/60-theme.lib.zsh

	for s in $SEGMENTS; do
		source ~/.tmux/segments/$s/$s.segment.zsh
		status_segment_$s
	done
}
