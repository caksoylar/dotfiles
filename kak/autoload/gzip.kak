# Enable kakoune to open, edit, write files compressed with gzip

hook -group gzip global BufOpenFile .*\.gz %{
    evaluate-commands %sh{
        if ! command -v truncate >/dev/null; then
            printf %s\\n 'fail "Need truncate tool to work with gzip files"'
        fi
    }
    gzip-decompress
    hook -group gzip buffer BufWritePre %val{buffile} gzip-precompress
    hook -group gzip buffer BufWritePost %val{buffile} gzip-postcompress
    echo -markup {Information}Decompressed: %val{buffile}
}

define-command -hidden gzip-decompress %{
    execute-keys -draft '%d<a-!>gzip -dc ' %val{buffile} '<ret>d'
}

define-command -hidden gzip-precompress %{
    nop %sh{ mv "${kak_buffile}" "${kak_buffile}~" }
    try %{
        execute-keys -draft '%|gzip -c<ret>'
    } catch %{
        nop %sh{ mv "${kak_buffile}~" "${kak_buffile}" }
        fail Unable to compress: %val{buffile}
    }
}

define-command -hidden gzip-postcompress %{
    nop %sh{ truncate -s-1 "${kak_buffile}" }  # get rid of the NL kak forces at the end of file
    nop %sh{ rm "${kak_buffile}~" }
    echo -markup {Information}Compressed: %val{buffile}
    edit!
    gzip-decompress
}
