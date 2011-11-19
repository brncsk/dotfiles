# Basics -------------------------------------------------------------------------------------- {{{

	[ -z "$PS1" ] && return

	HISTCONTROL=ignoredups:ignorespace
	HISTSIZE=10000
	HISTFILESIZE=20000

	shopt -s histappend
	shopt -s checkwinsize

	[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# }}}
# Prompt -------------------------------------------------------------------------------------- {{{

	# Replace name of certain directories with Unicode chars
	function sane_cwd {
		PPATH=${PWD/$HOME/⌂}
		PPATH=${PPATH/\/data/⛁}
	}

	function parse_git_branch {
		GITBRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/');
	}

	BLUE="\[\033[1;34m\]"
	GREEN="\[\033[1;32m\]"
	YELLOW="\[\033[1;33m\]"
	RESET="\[\033[0m\]"

	PROMPT_COMMAND='sane_cwd;parse_git_branch'
	PS1=$BLUE'[$(date +%H:%m)] '$GREEN"\u@\h:"'$PPATH'$YELLOW'$GITBRANCH ⊙ '$RESET

# }}}
# xterm miscellanea --------------------------------------------------------------------------- {{{

	case "$TERM" in
	xterm*|rxvt*)
		export TERM="xterm-256color" 
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
	esac

# }}}
# Aliases ------------------------------------------------------------------------------------- {{{

	if [ -x /usr/bin/dircolors ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
		alias ls='ls --color=auto'

		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
	fi

	alias alert='notify-send --urgency=low -i \
		"$([ $? = 0 ] && echo terminal || echo error)" \
		"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

	alias uu='sudo apt-get update && sudo apt-get upgrade'

# }}}
# Completion ---------------------------------------------------------------------------------- {{{

	if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
		. /etc/bash_completion
	fi

# }}}
