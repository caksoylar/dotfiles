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
            } catch %{
                echo -debug %val{error}
                evaluate-commands -client tools quit
            }"
        fi
    }
}
