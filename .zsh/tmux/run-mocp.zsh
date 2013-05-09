[ $# -gt 0 ] && {
    mocp --$1
} || {
    mocp_pane=$(tmux list-panes | grep -Po "([0-9]+)(?=: \[60x)")

    [ $mocp_pane ] \
        && tmux kill-pane -t $mocp_pane \
        || tmux split-window -h -l 60 mocp
}
