alias _='sudo'

alias sl=ls

alias ls='ls    -l --human-readable --group-directories-first --color=auto'
alias lS='ls -S -l --human-readable --group-directories-first --color=auto'
alias lsa='ls -a -l --human-readable --group-directories-first --color=auto'

alias  o='gnome-open'
alias so='gksudo gnome-open'

alias wd='watch -tc "dmesg | tail -$(tput lines)"'
