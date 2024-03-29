define-command -params 3 inc-dec %{
    try %{
        evaluate-commands %sh{
            [ "$1" = 0 ] && count=1 || count="$1"
            [ "$3" = 0 ] && mult=1  || mult="<c-r>#"
            printf '%s%s\n' 'execute-keys h"_/\d<ret><a-i>na' "$2($count * $mult)<ret><esc> | bc<ret><semicolon>dh<a-i>n"
        }
    }
} -docstring %{
    inc-dec <count> <op> <sequential>: increase (op=+) or decrease (op=-) selections by either count
    (default: 1) if sequential is zero, or count times selection index otherwise
}
