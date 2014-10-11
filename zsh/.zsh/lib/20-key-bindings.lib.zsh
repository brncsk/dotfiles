# Home goes to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi

# End goes to end of line
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line
fi

# M-l for ls
bindkey -s '\el' "ls\n"

# M-. for cd ..
bindkey -s '\e.' "..\n"

# M-~ for home
bindkey -s '\eh' "~\n"

# M-d for /data
bindkey -s '\ed' "/data\n"

# C-r for searching history
bindkey '^r' history-incremental-search-backward

# Perform history expansion on space
bindkey ' ' magic-space

# S-Tab for moving backwards in the completion menu
bindkey '^[[Z' reverse-menu-complete

# Del deletes a character
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
	bindkey "\e[3~" delete-char
fi
