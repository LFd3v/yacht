#!/usr/bin/env bash

DATE="$(date)"
SESSIONS="$(tmux ls | wc -l)"
tmux display-menu -T "#[align=centre]Status" -x P -y P \
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
