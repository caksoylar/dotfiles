define-command -hidden -params 3 inc-dec %{
    try %{
        evaluate-commands %sh{
            [ "$1" = 0 ] && count=1 || count="$1"
            [ "$3" = 0 ] && mult=1  || mult="<c-r>#"
            printf '%s%s\n' 'execute-keys h"_/\d<ret><a-i>na' "$2($count * $mult)<esc> | bc<ret><a-i>n"
        }
    }
}
declare-user-mode inc-dec
map global inc-dec a ': inc-dec %val{count} + 0<ret>' -docstring 'increment by count'
map global inc-dec x ': inc-dec %val{count} - 0<ret>' -docstring 'decrement by count'
map global inc-dec A ': inc-dec %val{count} + 1<ret>' -docstring 'increment by count times selection index'
map global inc-dec X ': inc-dec %val{count} - 1<ret>' -docstring 'decrement by count times selection index'
map global user m ': enter-user-mode inc-dec<ret>'       -docstring "enter inc-dec mode"
map global user M ': enter-user-mode -lock inc-dec<ret>' -docstring "enter inc-dec mode (lock)"
