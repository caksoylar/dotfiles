# from Screwtapello's https://discuss.kakoune.com/t/display-all-faces-in-the-current-color-scheme/
declare-option range-specs face_colors

define-command color-faces %{
    buffer *debug*
    debug faces
    try %{ remove-highlighter buffer/face-colors }
    set-option buffer face_colors %val{timestamp}

    evaluate-commands -draft %{
        execute-keys '%' s^Faces:\n(<space>\*<space>[^\n]*\n)*<ret>
        execute-keys s ^<space>\*<space><ret>
        execute-keys lt:

        evaluate-commands -itersel %{
            eval %sh{
                printf "set-option -add buffer face_colors %s|%s\n" \
                "$kak_selection_desc" "$kak_selection"
            }
        }
    }

    add-highlighter buffer/face-colors ranges face_colors
}
