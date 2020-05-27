define-command -hidden percent %{
    prompt "go-to-percent:" %{
        execute-keys %sh{
            count=$(printf '%s * %s / 100 + 1\n' "$kak_buf_line_count" "$kak_text" | bc)
            if [ "$count" -gt 1 ]; then
                printf '%s\n' "${count}g"
            else
                printf '%s\n' "gg"
            fi
        }
    }
}
