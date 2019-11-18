define-command -hidden -params 0 toggle-wrap %{
  try %{
    add-highlighter global/wrap wrap -marker "…"
  } catch %{
    remove-highlighter global/wrap
  }
}

add-highlighter global/wrap wrap -marker "…"
map global user w ': toggle-wrap<ret>' -docstring "toggle soft line wrap"
