define-command -hidden -params 0 toggle-list %{
    try %{
        add-highlighter global/listchars show-whitespaces -tab "»" -lf "↲" -nbsp "␣" -spc "·"
    } catch %{
        remove-highlighter global/listchars
    }
}

map global user l ': toggle-list<ret>' -docstring "toggle whitespace highlighting"
