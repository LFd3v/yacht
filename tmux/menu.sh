#!/usr/bin/env bash

DATE="$(date)"
SESSIONS="$(tmux ls | wc -l)"
CS="@continuum-save-interval"

MENU=(""
    "-${DATE}" "" {}
    "-#[align=centre]tmux #{version}" "" {}
    ""
    "-Continuum: #{?#{==:#{${CS}},15},15min,off}" "" {}
    "-Keep pane: #{?#{==:#{remain-on-exit},on},on,off}" "" {}
    "-Mouse: #{?mouse,on,off}" "" {}
    "-Session windows: #{session_windows}" "" {}
    "-Sessions: ${SESSIONS}" "" {}
    ""
    "[P] show Key bindings      " k "list-keys -N"
    "[P] Toggle clock mode      " t "run -b -d 0.2 -C 'clock-mode'"
    "[S] toggle Continuum       " c "set -g ${CS} #{?#{==:#{${CS}},15},0,15}"
    "[W] toggle keep Pane       " p "setw remain-on-exit"
    "[S] toggle Mouse           " m "setw mouse"
    "[S] toggle pAne status     " a "setw -g pane-border-status"
    "[S] toggle Status bar      " s "set status"
    "[W] toggle sYnchronization " y "setw synchronize-panes"
    "[S] toggle status Widgets  " w "run -C 'toggle-status-right'"
    ""
    "Detach session <P d>       " d "confirm-before -p 'detach from session #S? (y/N)' detach"
    "Navigate tree <P s>        " n "choose-tree -Z"
    "show/edit Buffers <P C-b>  " b "choose-buffer -Z"
    "Quit session <P C-q>       " q "confirm-before -p 'kill-session #S? (y/N)' kill-session")

[ "$1" == "K" ] && tmux display-menu \
    -T "#[align=centre]Status" -x C -y C "${MENU[@]}" || true
    
[ "$1" == "M" ] && tmux display-menu \
    -O -T "#[align=centre]Status" -x R -y S "${MENU[@]}" || true

