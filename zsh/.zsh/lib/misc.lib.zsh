# Include <Ctrl+C>'d commands in history
TRAPINT () {
	zle && print -s -- $BUFFER
	return $1
}

# URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Job listing in long format
setopt long_list_jobs

export PAGER=less
export LC_CTYPE=$LANG

setopt multios

GREP_OPTIONS="--color=auto \
			--exclude-dir=.bzr \
			--exclude-dir=.git"

# Enable syntax highlighting in some tools
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
