define-command -hidden clipboard-sync \
-docstring "yank selection to terminal clipboard using OSC 52" %{
    nop %sh{
        eval set -- "$kak_quoted_selections"
        copy=$1
        shift
        for sel; do
            copy=$(printf '%s\n%s' "$copy" "$sel")
        done
        encoded=$(printf %s "$copy" | base64 | tr -d '\n')

        [ -n "$TMUX" ] && tty=$(tmux display-message -p '#{pane_tty}') || tty=/dev/tty
        printf "\e]52;;%s\e\\" "$encoded" >"$tty"
    }
}
