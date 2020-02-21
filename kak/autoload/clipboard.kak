define-command -docstring "yank selection to Tmux and/or Windows clipboard" \
clipboard-sync -hidden %{
    evaluate-commands %sh{
        if [ -n "$TMUX" ]; then
            tmux set-buffer -- "$kak_selection"
        fi
        if command -v clip.exe >/dev/null; then
            printf '%s\n' 'execute-keys <a-|>clip.exe<ret>'
        fi
    }
}
map global normal <a-y> ': clipboard-sync<ret>'
