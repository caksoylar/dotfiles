# set tools/jumpclient for tools like grep/make
define-command tool -params .. -command-completion -docstring "create tool split and run command" %{
    evaluate-commands %sh{
        # if main client doesn't exist, set current as main
        if [ "${kak_client_list#*main}" = "$kak_client_list" ]; then
            printf '%s\n' "rename-client main; set global jumpclient main"
            printf '%s\n' "try %{ set-option window scroll_client main }"  # for kakoune-smooth-scroll
        fi
        # create tools client and run
        if [ "${kak_client_list#*tools}" = "$kak_client_list" ]; then
            printf '%s\n' \
            "set global toolsclient tools
            split %{
                rename-client tools
                try %{
                    evaluate-commands -client main $*
                    map window normal q ': quit<ret>'
                    execute-keys <a-k>\\S<ret>
                } catch %{
                    echo -debug %val{error}
                    quit
                }
            }"
        else  # tools client exists, just run command
            printf '%s\n' \
            "try %{
                evaluate-commands -client main $*
                map window normal q ': quit<ret>'
                execute-keys <a-k>\\S<ret>
            } catch %{
                echo -debug %val{error}
                evaluate-commands -client tools quit
            }"
        fi
    }
}

# from https://discuss.kakoune.com/t/single-command-for-grep-next-match-in-similar-buffers-lsp-make-find/
declare-option -hidden str tool_buffer

hook -group tool global WinDisplay \
    \*(?:grep|find|make|lint-output|references|diagnostics|implementations|symbols|cargo)\* %{
    set-option global tool_buffer %val{bufname}
}

define-command tool-next-match \
    -docstring 'Jump to the next match in a grep-like buffer' %{
    evaluate-commands -try-client %opt{jumpclient} %{
        buffer %opt{tool_buffer}
        execute-keys "<a-l> /^[^:\n]+:\d+:<ret>"
        grep-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{
        buffer %opt{tool_buffer}
        execute-keys gg %opt{grep_current_line}g
    }}
}

define-command tool-previous-match \
    -docstring 'Jump to the previous match in a grep-like buffer' %{
    evaluate-commands -try-client %opt{jumpclient} %{
        buffer %opt{tool_buffer}
        execute-keys "g<a-h> <a-/>^[^:\n]+:\d+:<ret>"
        grep-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{
        buffer %opt{tool_buffer}
        execute-keys gg %opt{grep_current_line}g
    }}
}
