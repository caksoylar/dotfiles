# cursorline highlighting
define-command cursorline-enable %{
    hook global -group cursorline NormalKey .* %{
        remove-highlighter window/cursorline
        add-highlighter window/cursorline line %val{cursor_line} CursorLine
    }
}

define-command cursorline-disable %{
    remove-highlighter window/cursorline
    remove-hooks global cursorline
}

define-command cursorline-toggle %{
    try %{
        add-highlighter window/cursorline fill Normal  # dummy to throw error if enabled
        cursorline-enable
    } catch %{
        cursorline-disable
    }
}

cursorline-enable
map global user c ': cursorline-toggle<ret>' -docstring "toggle cursorline highlighting"
