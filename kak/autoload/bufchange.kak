declare-option -hidden int prev_timestamp 0

hook -group buf-change global NormalIdle .* %{
    evaluate-commands %sh{
        if [ "$kak_timestamp" -gt "$kak_opt_prev_timestamp" ]; then
            printf 'trigger-user-hook BufChange\n'
            printf 'set-option buffer prev_timestamp %s\n' "$kak_timestamp"
        fi
    }
}
