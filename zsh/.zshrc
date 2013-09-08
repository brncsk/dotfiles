# Hello, my name is --------------------------------------------------------------------------- {{{

	export NAME="Ádám Barancsuk"
	export EMAIL="adam.barancsuk@gmail.com"

	export DEBFULLNAME=$NAME
	export DEBEMAIL=$EMAIL
	
	export TOMLAB_LICENSE_FILE=/usr/local/tomlab/tomlab.lic
# --------------------------------------------------------------------------------------------- }}}
# Tool prefs ---------------------------------------------------------------------------------- {{{

	export EDITOR=vim
	export VISUAL=gedit
	export BROWSER=google-chrome

	#export TERM=screen-256color
	[ "$TERM" = screen ] && export TERM=rxvt-256color


	[[ -f /usr/share/vim/vimcurrent/macros/less.sh ]] &&
		alias vless='/usr/share/vim/vimcurrent/macros/less.sh'

	[[ -f /etc/zsh_command_not_found ]] &&
		. /etc/zsh_command_not_found

	GREP_OPTIONS="--color=auto \
				--exclude-dir=.bzr \
				--exclude-dir=.git"

	# Save <Ctrl-C>'d commands in history
	TRAPINT () {
		zle && print -s -- $BUFFER
		return $1
	}

	# Command line syntax highlighting
	(( $+commands[highlight] )) && {
		function cat sed awk grep () {
			local syntax

			for file in $@; do
				if [[ -f $file ]]; then
					case $file in
						*.java)		syntax='java';;
						*.php)		syntax='php';;
						*.py)		syntax='python';;
						*.diff)		syntax='diff';;
						*.awk)		syntax='awk';;
						*.c)		syntax='c';;
						*.css)		syntax='css';;
						*.js)		syntax='js';;
						*.jsp)		syntax='jsp';;
						*.xml)		syntax='xml';;
						*.sql)		syntax='sql';;
						*.pl)		syntax='pl';;
						*.sh|*.zsh)	syntax='sh';;
					esac
				fi
			done
				
			if [[ -n $syntax ]]; then
				command $0 $@ | highlight --syntax=$syntax --out-format=xterm256 --style=molokai
			else
				command $0 $@
			fi
		}
	}

# --------------------------------------------------------------------------------------------- }}}
# Oh-my-zsh ----------------------------------------------------------------------------------- {{{

	ZSH=$HOME/.oh-my-zsh
	ZSH_THEME="brncsk"
	DISABLE_AUTO_UPDATE="true"
	COMPLETION_WAITING_DOTS="true"
	
	plugins=(archlinux git loadavg)

	source $ZSH/oh-my-zsh.sh

# --------------------------------------------------------------------------------------------- }}}
# Path ---------------------------------------------------------------------------------------- {{{

	PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
	PATH+=":/usr/games:/data/applications/android-sdk-linux/platform-tools"
	export PATH

# --------------------------------------------------------------------------------------------- }}}
# Aliases ------------------------------------------------------------------------------------- {{{

	alias ls='ls    -l --human-readable --group-directories-first --color=auto'
	alias lS='ls -S -l --human-readable --group-directories-first --color=auto'

	alias  o='gnome-open'
	alias so='gksudo gnome-open'

	alias  c='echo `xsel` >> /data/temp/dicthist; dict `xsel`'

	alias cdd='cd /data/$1'

# --------------------------------------------------------------------------------------------- }}}
