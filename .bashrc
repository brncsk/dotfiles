# Basics -------------------------------------------------------------------------------------- {{{

	[ -z "$PS1" ] && return

	HISTCONTROL=ignoredups:ignorespace
	HISTSIZE=10000
	HISTFILESIZE=20000

	shopt -s histappend
	shopt -s checkwinsize

	[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

	export PATH=$PATH:/data/applications/android-sdk-linux/platform-tools

# }}}
# Prompt -------------------------------------------------------------------------------------- {{{

	# Replace name of certain directories with Unicode chars
	function sane_cwd {
		PROMPTCHAR=❯
		PPATH=${PWD/$HOME\//⌂ → }
		PPATH=${PPATH/$HOME/⌂}
		PPATH=${PPATH/\/data\/documents\//⛁ →   → }
		PPATH=${PPATH/\/data\/documents/⛁ →  }
		PPATH=${PPATH/\/data\/music\//⛁ → ♫ → }
		PPATH=${PPATH/\/data\/music/⛁ → ♫}
		PPATH=${PPATH/\/data\//⛁ → }
		PPATH=${PPATH/\/data/⛁}
	}

	function parse_git_info {
		git_branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
		if [ ! -z $git_branch ]; then
			PROMPTCHAR=∓
			git_stat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

			if [[ $(echo $git_stat | grep -c "to be committed:") > 0 ]]; then
				git_extra="*"
			fi

			if [[ $(echo ${git_stat} | grep -c "\(Untracked\|but not updated\)") > 0 ]]; then
				git_extra="!"
			fi 
			
			GITINFO="($git_branch$git_extra) "
		else
			GITINFO=""
		fi
	}

	function build_prompt {
		DATE=$(date +%H:%m)
		LOAD=$(cat /proc/loadavg | cut -d' ' -f1)
		STATUS="";
#		prompt="$USERNAME on $HOSTNAME : $PPATH $GITBRANCH > "
#		fillcharlen=$((COLUMNS-${#prompt}-${#STATUS}))
#		FILL="\[\033[${fillcharlen}C\]"
	}

	BLUE="\[\033[0;38;5;39m\]"
	GREEN="\[\033[0;38;5;154m\]"
	ORANGE="\[\033[1;38;5;208m\]"
	DARKGREY="\[\033[0;38;5;239m\]"
	GREY="\[\033[0;38;5;245m\]"
	PINK="\[\033[1;38;5;198m\]"
	RESET="\[\033[0m\]"
	CUR_SAVE="\[\033[s\]"
	CUR_RESTORE="\[\033[u\]"

	PROMPT_COMMAND='sane_cwd;parse_git_info;build_prompt'
	PS1=$GREY'$STATUS'$GREEN"\u"$GREY" @ "$BLUE"\h"$GREY" : "\
$PINK'$PPATH '$ORANGE'$GITINFO'$GREY'$PROMPTCHAR '$RESET

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
		alias ls='ls -lh --color=auto'

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
