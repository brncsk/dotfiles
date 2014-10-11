# Poor man's `chsh`: drop us into zsh if it's available.
PATH=~/staging/bin:$PATH
if command -v zsh >/dev/null 2>&1 && ! [ -z $PS1 ]; then
	zsh
	exit
fi

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
		case `term_type` in
			xterm|xscreen)
				PROMPTCHAR="❯"
				GITPROMPTCHAR="∓"
				HOMECHAR="⌂"
				DATACHAR="⛁"
			;;
			*)
				PROMPTCHAR=">"
				GITPROMPTCHAR="+"
				HOMECHAR="~"
				DATACHAR="D"
			;;
		esac
		
		PPATH=${PWD/$HOME\//$HOMECHAR → }
		PPATH=${PPATH/$HOME/$HOMECHAR}
		PPATH=${PPATH/\/data\/documents\//$DATACHAR →   → }
		PPATH=${PPATH/\/data\/documents/$DATACHAR →  }
		PPATH=${PPATH/\/data\/music\//$DATACHAR → ♫ → }
		PPATH=${PPATH/\/data\/music/$DATACHAR → ♫}
		PPATH=${PPATH/\/data\//$DATACHAR → }
		PPATH=${PPATH/\/data/$DATACHAR}
	}

	function parse_git_info {
		git_branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
		if [ ! -z $git_branch ]; then
			PROMPTCHAR=$GITPROMPTCHAR
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

	function term_type {
		([[ `tty` == *tty* ]] && echo 'tty') || \
		([[ `tty` == *pts* && $TERM == *screen* ]] && echo 'xscreen') || \
		([[ $TERM == *screen* ]] && echo 'screen') || \
		([[ $TERM == *xterm* ]] && echo 'xterm') || \
		echo 'unknown'
	}

	function setup_term_dependent_stuff {
		case `term_type` in
			tty)
				BLUE="\[\033[1;34m\]"
				GREEN="\[\033[1;32m\]"
				ORANGE="\[\033[1;33m\]"
				DARKGREY="\[\033[1;30m\]"
				GREY="\[\033[1;30m\]"
				PINK="\[\033[1;35m\]"
			;;

			screen|xterm|xscreen)
				BLUE="\[\033[0;38;5;39m\]"
				GREEN="\[\033[0;38;5;154m\]"
				ORANGE="\[\033[1;38;5;208m\]"
				DARKGREY="\[\033[0;38;5;239m\]"
				GREY="\[\033[0;38;5;245m\]"
				PINK="\[\033[1;38;5;198m\]"
			;;

			*)
			;;
		esac
				
		RESET="\[\033[0m\]"
		CUR_SAVE="\[\033[s\]"
		CUR_RESTORE="\[\033[u\]"
	}
	
	function build_prompt {
		DATE=$(date +%H:%m)
		LOAD=$(cat /proc/loadavg | cut -d' ' -f1)
	}

	setup_term_dependent_stuff
	PROMPT_COMMAND='sane_cwd;parse_git_info;build_prompt'
	PS1=$GREEN"\u"$GREY" @ "$BLUE"\h"$GREY" : "
	PS1+=$PINK'$PPATH '$ORANGE'$GITINFO'$GREY'$PROMPTCHAR '$RESET

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

	alias uu='sudo apt-get update && sudo apt-get dist-upgrade'

	alias bgd='bg && disown'

	alias adb-start='sudo /data/applications/android-sdk-linux/platform-tools/adb start-server'
	
	function adb-push () {
		if [ ! -z "$1" ]
		then
			for i in $1; do
				adb push $1 /sdcard/
			done
		fi
	}

# }}}
# Completion ---------------------------------------------------------------------------------- {{{

	if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
		. /etc/bash_completion
	fi

# }}}
