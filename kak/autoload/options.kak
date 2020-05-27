# cursorline highlighting
define-command cursorline-toggle %{
    try %{
        add-highlighter window/cursorline fill Normal  # dummy to throw error if enabled
        hook window -group cursorline NormalKey .* %{
            remove-highlighter window/cursorline
            add-highlighter window/cursorline line %val{cursor_line} CursorLine
        }
    } catch %{
        remove-highlighter window/cursorline
        remove-hooks window cursorline
    }
}

# line-numbers highlighting
define-command line-numbers-toggle %{
    try %{
        add-highlighter window/line-numbers number-lines -hlcursor
    } catch %{
        remove-highlighter window/line-numbers
    }
}

# show whitespaces
define-command -hidden -params 0 whitespaces-toggle %{
    try %{
        add-highlighter window/whitespaces show-whitespaces -tab "»" -lf "↲" -nbsp "␣" -spc "·"
    } catch %{
        remove-highlighter window/whitespaces
    }
}

# soft line-wrapping
define-command -hidden -params 0 softwrap-toggle %{
    try %{
        add-highlighter window/wrap wrap -marker "…"
    } catch %{
        remove-highlighter window/wrap
    }
}
