define-command -hidden -params 2 inc %{
  evaluate-commands %sh{
    [ "$1" = 0 ] && count=1 || count="$1"
    printf '%s%s\n' 'execute-keys h"_/\d<ret><a-i>na' "$2($count)<esc> | bc<ret>h"
  }
}
map global normal <c-a> ': inc %val{count} +<ret>'
map global normal <c-x> ': inc %val{count} -<ret>'
