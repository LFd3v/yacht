#!/usr/bin/env bash

DATE="$(date)"
SESSIONS="$(tmux ls | wc -l)"
CS=$(~/.config/tmux/plugins/tmux-continuum/scripts/continuum_status.sh)
[ "$CS" == "off" ] && CI="15" || CI="0"
[ "$CS" == "off" ] && CM="" || CI="min"

tmux display-menu -T "#[align=centre]Status" -x P -y P \
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
