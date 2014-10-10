alias _='sudo'

alias sl=ls

alias ls='ls    -l --human-readable --group-directories-first --color=auto'
alias lS='ls -S -l --human-readable --group-directories-first --color=auto'
alias lsa='ls -a -l --human-readable --group-directories-first --color=auto'

alias  o='gnome-open'
alias so='gksudo gnome-open'

alias wd='watch -tc "dmesg | tail -$(tput lines)"'

# Directories

alias cd..='cd    ..'
alias cd...='cd   ../..'
alias cd....='cd  ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

alias ..='cd    ..'
alias ...='cd   ../..'
alias ....='cd  ../../..'
alias .....='cd ../../../..'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

alias d='dirs -v'
# Corrections

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias mkdir='nocorrect mkdir'
alias vim='nocorrect vim'
