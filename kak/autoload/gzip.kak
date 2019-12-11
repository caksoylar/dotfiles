# Enable kakoune to open, edit, write files compressed with gzip

hook -group gzip global BufOpenFile .*\.gz %{
    set-option buffer autoreload no
    evaluate-commands %sh{
        f="${kak_buffile%.gz}"
        umask 066
        gzip -dk "${kak_buffile}"

        if [ 0 -eq $? ]; then
            printf %s\\n "
                evaluate-commands %{
                    edit! '$f'
                    hook -group gzip buffer BufWritePost %val{buffile} gzip-compress
                    hook -group gzip buffer BufClose %val{buffile} gzip-cleanup
                    echo -markup {Information}Decompressed: ${kak_buffile}
                }"
        else 
            printf %s\\n "echo -markup {Error}Failed to decompress ${kak_buffile}"    
        fi
    }
}

define-command -hidden gzip-compress %{
    evaluate-commands %sh{
        mv "${kak_buffile}.gz" "${kak_buffile}.gz~"
        gzip -k "${kak_buffile}"

        if [ 0 -eq $? ]; then
            printf %s\\n "echo -markup {Information}Compressed: ${kak_buffile}.gz"
            rm -f "${kak_buffile}.gz~"
        else
            printf %s\\n "echo -markup {Error}Failed to compress: ${kak_buffile}.gz"
            mv "${kak_buffile}.gz~" "${kak_buffile}.gz"
        fi
    }
}

define-command -hidden gzip-cleanup %{
    evaluate-commands %sh{
        if [ -f "${kak_buffile}" ]; then
            rm "${kak_buffile}"
        fi
    }
    try %{ delete-buffer "%val{buffile}.gz" }
}
