STOW=stow

.PHONY: stow
stow:
	for d in bash git qgis ssh terminfo tmux vim x zsh; do	\
		${STOW} -t $$HOME $$d;							\
	done;												\
	sudo ${STOW} -t / root
