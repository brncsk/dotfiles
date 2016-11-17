# Home goes to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi

# End goes to end of line
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line
fi

# Del deletes a character
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
	bindkey "\e[3~" delete-char
fi

# M-l for lsa, M-L for ls (I use the former way more often so add the extra modifier to the latter)
bindkey -s '\el' "lsa\n"
bindkey -s '\eL' "ls\n"

# M-g for `git status` M-G for `git log`
bindkey -s '\eg' "gst\n"
bindkey -s '\eG' "gl\n"

# M-. for cd ..
bindkey -s '\e.' "..\n"

# M-f for fg
bindkey -s '\ef' "fg\n"

# M-v for vim
bindkey -s '\ev' "vim\n"

# M-h for home
bindkey -s '\eh' "~\n"

# M-d for /data
bindkey -s '\ed' "/data\n"

# M-Space for qalc
function _qalc_then_xclip () {
	print -s -r -- ${BUFFER}
	echo
	qalc +u8 -t "${${${${BUFFER:s/huf/HUF}:s/usd/USD}:s/eur/EUR}:s/ in / to }" | tee /dev/fd/2 | xclip -selection clipboard
	zle send-break
}
zle -N _qalc_then_xclip
bindkey '\e ' _qalc_then_xclip


# M-e edits the current line
autoload edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# M-, for !$
bindkey '\e,' insert-last-word

# C-r for searching history
bindkey '^r' history-incremental-search-backward

# Perform history expansion on space
bindkey ' ' magic-space

# S-Tab for moving backwards in the completion menu
bindkey '^[[Z' reverse-menu-complete

# M-Return autojumps to the current line
function _complete_and_autojump () {
	BUFFER="j ${BUFFER}"
	zle accept-line
}
zle -N _complete_and_autojump
bindkey '\e\r' _complete_and_autojump

# Clear screen on C-f (C-l is bound by vim-tmux-navigator)
bindkey -s '^f' "clear\n"
