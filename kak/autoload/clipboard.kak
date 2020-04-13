define-command -docstring "yank selection to terminal clipboard using OSC 52" \
clipboard-sync -hidden -override %{
    nop %sh{
        eval set -- "$kak_quoted_selections"
        copy=$1
        shift
        for sel; do
            copy=$(printf '%s\n%s' "$copy" "$sel")
        done
        encoded=$(printf %s "$copy" | base64 | tr -d '\n')
        printf "\e]52;;%s\e\\" "$encoded" >/dev/tty
    }
}
map global normal <a-y> ': clipboard-sync<ret>'
