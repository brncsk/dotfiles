# Enable automatic corrections (TODO: reconsider disabling this, it's more annoying than useful)
	setopt correct

# Set up directory stack and provide a utility function
# for creating than switching to a new directory
	setopt cdablevars
	setopt auto_cd
	setopt auto_pushd
	setopt pushd_ignore_dups

	function mcd () { 
		mkdir -p "$1" && cd "$1"; 
	}

	function fw () {
		file $(which $1)
	}

# History configuration
	HISTFILE=$HOME/.zsh_history
	HISTSIZE=10000
	SAVEHIST=10000

	setopt append_history
	setopt extended_history
	setopt hist_expire_dups_first
	setopt hist_ignore_dups
	setopt hist_ignore_space
	setopt hist_verify
	setopt inc_append_history
	setopt share_history

# Include <Ctrl+C>'d commands in history
	function TRAPINT () {
		print -s -r -- $BUFFER
		return $1
	}

	function zle-line-init () {
		zle reset-prompt
	}

	zle -N zle-line-init

# Syntax highlighting (installed from AUR)
	[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Job listing in long format
	setopt long_list_jobs

# Enable syntax highlighting in some tools
	[[ -x $(which highlight) ]] && {
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

# Find in files
	ff () {
		(find ${2:=.} -print0 | xargs -0 grep -i $1 ) 2>/dev/null
	}

# Mass renaming with zmv

	autoload -U zmv


# Set up ssh-agent

[ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=$(ls -l /tmp/ssh-*/agent.* 2> /dev/null | head -1 | grep $(whoami) | awk '{print $9}')
[[ -z "$SSH_AGENT_PID" && -z `echo $SSH_AUTH_SOCK | cut -d. -f2` ]] && SSH_AGENT_PID=$((`echo $SSH_AUTH_SOCK | cut -d. -f2` + 1))
[ -n "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK
[ -n "$SSH_AGENT_PID" ] && export SSH_AGENT_PID


# Misc.
	export PAGER=less
	export LC_CTYPE=$LANG

	setopt multios

	GREP_OPTIONS="--color=auto \
				--exclude-dir=.bzr \
				--exclude-dir=.git"

