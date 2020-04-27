define-command -hidden -params 0 listchars-toggle %{
    try %{
        add-highlighter global/listchars show-whitespaces -tab "»" -lf "↲" -nbsp "␣" -spc "·"
    } catch %{
        remove-highlighter global/listchars
    }
}

map global user l ': listchars-toggle<ret>' -docstring "toggle whitespace highlighting"
