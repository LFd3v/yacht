#!/usr/bin/env bash

tmux select-layout $DEFAULT_LAYOUT
tmux set -gw main-pane-width $DEFAULT_HW
tmux set -gw main-pane-height $DEFAULT_HW

DATE="$(date)"
SESSIONS="$(tmux ls | wc -l)"
CS=$(~/.config/tmux/plugins/tmux-continuum/scripts/continuum_status.sh)
CS=$(~/.config/tmux/plugins/tmux-continuum/scripts/continuum_status.sh)
[ "$CS" == "off" ] && CI="15" || CI="0"
[ "$CS" == "off" ] && CM="" || CI="min"

tmux bind -T root MouseDown3StatusRight display-menu -O -T "#[align=centre]Status" -t = -x M -y S \
    "" \
    "-#[nodim]$DATE" "" {} \
    "-#[nodim]#[align=centre]tmux #{version}" "" {} \
    "" \
    "-#[nodim]Continuum: ${CS}${CM}" "" {} \
    "-#[nodim]Mouse: #{?mouse,on,off}" "" {} \
    "-#[nodim]Session windows: #{session_windows}" "" {} \
    "-#[nodim]Sessions: $SESSIONS" "" {} \
    "" \
    "Choose tree" c "choose-tree -Z" \
    "Detach" d "confirm-before -p 'detach from session #S? (y/N)' detach" \
    "display Time" t "run -b -d 0.2 'tmux clock-mode'" \
    "display Buffers" b "choose-buffer -Z" \
    "toggle continUum" u "set -g @continuum-save-interval $CI" \
    "toggle Mouse" m "setw mouse" \
    "" \
    "Quit" q "confirm-before -p 'kill-session #S? (y/N)' kill-session"

