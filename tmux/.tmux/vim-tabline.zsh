#!/bin/zsh

export THEME_BACKEND=tmux

source ~/.zsh/lib/50-presentation.lib.zsh
source ~/.zsh/lib/60-theme.lib.zsh

TABFILE=~/.tmux/.vim-tablist

if [[ "$(pgrep vim$)" != "" ]]; then

	echo -n "$BG[0]$FG[238]$CH[Al]$BG[238]$FG[0] $CH[V]  "

	foreach t ("${(f)$(cat $TABFILE)}"); do
		current=0; unsaved=;
		[[ $t == '>'* ]] && { current=1; };
		[[ $t == *'*' ]] && { unsaved="$FG[red] ★"; };
		
		t=${${t:s/>//}:s/*//}
		[[ "$t" == '' ]] && t="$FX[i+](unsaved buffer)$FX[i-]";

		if [[ $current == 1 ]]; then
			echo -n "$BG[238]$FG[230]$BG[230]$FG[black]$FX[b+] $t$unsaved $FX[b-]$BG[238]$FG[230]$FX[0]$BG[238] "
		else
			echo -n "$BG[238]$FG[236]$BG[236]$FG[248] $t$unsaved $BG[238]$FG[236]$FX[0]$BG[238] "
		fi

	done
	echo -n "$BG[0]$FG[238]$CH[Ar]"
fi
