# M-l for ls
bindkey -s '\el' "ls\n"

# M-. for cd ..
bindkey -s '\e.' "..\n"

# C-r for searching history
bindkey '^r' history-incremental-search-backward

# Perform history expansion on space
bindkey ' ' magic-space

# S-Tab for moving backwards in the completion menu
bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey "\e[3~" delete-char
