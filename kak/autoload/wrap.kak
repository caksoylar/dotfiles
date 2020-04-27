define-command -hidden -params 0 softwrap-toggle %{
    try %{
        add-highlighter global/wrap wrap -marker "…"
    } catch %{
        remove-highlighter global/wrap
    }
}

add-highlighter global/wrap wrap -marker "…"
map global user w ': softwrap-toggle<ret>' -docstring "toggle line soft wrap"
