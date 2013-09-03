#!/bin/bash

TO_HOME=(.bashrc .git .gitconfig .gitignore .oh-my-zsh .ssh .terminfo .tmux.conf .vim .vimrc \
	.xinitrc .Xmodmap .zsh .zshrc)

for f in ${TO_HOME[@]}; do
	rm -rf $HOME/$f
	[[ -f $HOME/$f ]] && {
		echo "$HOME/$f exists, replacing."
		rm -rf $HOME/$f
	}

	ln -s `readlink -f $f` $HOME/$f
done
