#!/usr/bin/zsh

[ -n $TMUX ] && () {
	source ~/.zsh/lib/presentation.lib.zsh
	source ~/.zsh/lib/theme.lib.zsh

	. ~/.zsh/tmux/tmuxload/tmuxload.plugin.zsh
	. ~/.zsh/tmux/tmuxtemp/tmuxtemp.plugin.zsh
	. ~/.zsh/tmux/tmuxsound/tmuxsound.plugin.zsh
	. ~/.zsh/tmux/tmuxwifi/tmuxwifi.plugin.zsh
	. ~/.zsh/tmux/tmuxbattery/tmuxbattery.plugin.zsh
	. ~/.zsh/tmux/tmuxclock/tmuxclock.plugin.zsh

	tmuxsound
	tmuxwifi
	tmuxbattery
	loadavg
	acpitemp
	tmuxclock
}
