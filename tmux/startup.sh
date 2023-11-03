#!/usr/bin/env bash

tmux select-layout "${DEFAULT_LAYOUT}"
tmux set -gw main-pane-width "${DEFAULT_HW}"
tmux set -gw main-pane-height "${DEFAULT_HW}"

CS="@continuum-save-interval"

MENU=(""
    "-Continuum: #{?#{==:#{${CS}},15},15min,off}" "" {}
    "-Keep pane: #{?#{==:#{remain-on-exit},on},on,off}" "" {}
    "-Mouse: #{?mouse,on,off}" "" {}
    "-Session windows: #{session_windows}" "" {}}
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

tmux bind -N "Show status menu" Home run -b -t = "~/.config/tmux/menu.sh K"

tmux bind -T root MouseDown3StatusRight display-menu \
    -O -T "#[align=centre]Status" -t = -x M -y S "${MENU[@]}"


