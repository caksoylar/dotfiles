hook -group ipynb global BufOpenFile .*[.](ipynb) %{
    set-option buffer filetype ipynb
}

hook -group ipynb global WinSetOption filetype=ipynb %{
    require-module json
    require-module ipynb

    add-highlighter window/ipynb ref json
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/ipynb }

    set-option window formatcmd "jq ."
    map window normal <ret> ": decode-field<ret>"
}

provide-module ipynb %{
    define-command -hidden decode-field %{
        try %{
            evaluate-commands -save-regs j %{
                execute-keys <a-a>r <">jy
                edit -scratch "*ipynb-cell*"
                set-option buffer filetype python
                execute-keys -draft <">jP ggI{<">text<">:<esc>gea}<esc> <%> | jq<space>-r<space>'.text|join("")' <ret>
                map buffer normal <ret> ": replace-field<ret>"
            }
        }
    }

    define-command -hidden replace-field %{
        evaluate-commands -save-regs j %{
            execute-keys -draft <%> | "jq -Rs ." <ret> <">jy
            delete-buffer
            execute-keys -draft <">jR s <\><\>n<"> <ret> Hd jd
        }
    }
}
