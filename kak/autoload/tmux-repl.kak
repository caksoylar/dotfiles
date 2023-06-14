define-command -params 0..1 tmux-repl-set-pane-by-index -docstring %{
        tmux-repl-set-pane [pane index]: Set an existing tmux pane for repl interaction
        Uses pane **index** rather than pane **id**.
        If the address of new pane is not given, next pane is used
        (To get the pane number in tmux, use "tmux display-message -p '#{pane_index}'"
        in that pane, or "prefix q" to display all pane indices in window)
} %{
    evaluate-commands %sh{
        if [ -z "$TMUX" ]; then
            echo 'fail This command is only available in a tmux session'
            exit
        fi
        if [ $# -eq 0 ]; then
            curr_pane_index="$(tmux display-message -p -t "${kak_client_env_TMUX_PANE}" '#{pane_index}')"
            tgt_pane_index=$((curr_pane_index+1))
        else
            tgt_pane_index="$1"
        fi
        tgt_pane="$(tmux display-message -p -t "$tgt_pane_index" '#{pane_id}')"

        curr_win="$(tmux display-message -t "${kak_client_env_TMUX_PANE}" -p '#{window_id}')" 
        if tmux list-panes -t "$curr_win" -F '#D' | grep -Fxq "$tgt_pane"; then
            printf "set-option current tmux_repl_id '%s'" "$tgt_pane"
        else
            echo 'fail The correct pane is not there. Activate using tmux-terminal-* or some other way'
        fi
    }
}

define-command tmux-send-selection -params 0 -docstring %{
        tmux-send-selection: Send selection to the REPL pane using bracketed paste.
    } %{
    evaluate-commands -draft %{
        execute-keys <a-:>
        evaluate-commands %sh{
            # use bracketed paste rather than normal
            tmux set-buffer -b kak_selection -- "${kak_selection}"
            tmux paste-buffer -p -b kak_selection -t "$kak_opt_tmux_repl_id" ||
            echo 'fail tmux-send-selection: failed to send text, see *debug* buffer for details'

            # if selection ends with a newline (10) send an enter at the end
            if [ "$kak_cursor_char_value" -eq 10 ]; then
                tmux send-keys -t "$kak_opt_tmux_repl_id" -H A
            fi
        }
    }
}
