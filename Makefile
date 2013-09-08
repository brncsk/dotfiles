STOW=stow

.PHONY: stow
stow:
	for d in bash git ssh terminfo tmux vim x zsh; do	\
		${STOW} -t $$HOME $$d;							\
	done
