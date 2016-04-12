alias _='sudo'

alias sl=ls

alias ls='ls     -l -h'
alias lS='ls  -S -l -h'
alias lsa='ls -a -l -h'

alias  o='gnome-open'
alias so='gksudo gnome-open'

alias wd='watch -tc "dmesg | tail -$(tput lines)"'

# Directories

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

# Git

alias gc='git commit -v'
compdef _git gc=git-commit

alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcamn='git commit --amend --no-edit'

alias gst='git status'
compdef _git gst=git-status

alias gp='git push'
compdef _git gp=git-push

alias gpo='git push origin'
compdef _git gpo=git-push

alias gpoa='git push origin --all'
compdef _git gpoa=git-push

alias gd='git difftool'
compdef _git gd=git-diff

alias gco='git checkout'
compdef _git gco=git-checkout

alias gb='git branch'
compdef _git gb=git-branch

alias gbl='git branch --list'
compdef _git gbl=git-branch

alias gl='git lg'
compdef _git gl=git-log

alias glp='git lg -p'
compdef _git glp=git-log

alias gst='git status'
compdef _git gst=git-status

alias ga='git add'
compdef _git ga='git-add'

alias grh='git reset HEAD'

alias grb='git rebase'
compdef _git grb='git-rebase'

# Prevent correcting these

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias mkdir='nocorrect mkdir'
alias vim='nocorrect vim'

alias scs='sudo systemctl start'
alias scr='sudo systemctl restart'
alias sct='systemctl status'
