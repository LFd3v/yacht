#!/usr/bin/env bash

tmux select-layout main-vertical
tmux set -gw main-pane-width 60

DATE="$(date)"
SESSIONS="$(tmux ls | wc -l)"
tmux bind -T root MouseDown3StatusRight display-menu -O -T "#[align=centre]Status" -t = -x M -y S \
    "" \
    "-#[nodim]$DATE" "" {} \
    "-#[nodim]Mouse: #{?mouse,on,Off}" "" {} \
    "-#[nodim]Session windows: #{session_windows}" "" {} \
    "-#[nodim]Sessions: $SESSIONS" "" {} \
    "-#[nodim]Version: #{version}" "" {} \
    "" \
    "Choose tree" c "choose-tree -Z" \
    "Detach" d "confirm-before -p 'detach from session #S? (y/N)' detach" \
    "display Time" t "run -b -d 0.2 'tmux clock-mode'" \
    "display Buffers" b "choose-buffer -Z" \
    "toggle Mouse" m "setw mouse" \
    "" \
    "Quit" q "confirm-before -p 'kill-session #S? (y/N)' kill-session"

