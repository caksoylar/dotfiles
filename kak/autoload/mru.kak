declare-option -hidden str-list mru_buffers

hook global BufCreate [^*].* %{
    set-option -remove global mru_buffers %val{hook_param}
    set-option -add global mru_buffers %val{hook_param}
}

hook global KakBegin .* %{
    state-save-reg-load b
    set-option global mru_buffers %reg{b}
}
hook global KakEnd .* %{
    set-register b %opt{mru_buffers}
    state-save-reg-save b
}

define-command mru -docstring "Display most recently used files, press return to edit" %{
    try %{ delete-buffer *mru* }
    edit -scratch *mru*
    evaluate-commands -save-regs b %{
        set-register b %opt{mru_buffers}
        execute-keys '"b<a-P><a-space><a-,>a<ret><esc>gj'
    }
    map buffer normal <ret> "<semicolon>x_:edit <c-r>.<ret>"
}
