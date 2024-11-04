declare-option -hidden int-list tsobj_offsets                                               # cursor byte offsets
declare-option -hidden str tsobj_buf                                                        # temporary file with buffer contents
declare-option -hidden str-list tsobj_selections                                            # selections
declare-option -hidden int tsobj_prev_timestamp 0                                           # track timestamp changes
declare-option -hidden str tsobj_script %sh{printf "%s/kts.py" "$(dirname "$kak_source")"}  # python script path

define-command ts-objects-select -params 2 %{
    # convert cursors to byte offsets
    set-option window tsobj_offsets
    evaluate-commands -itersel %{
        set-option -add window tsobj_offsets %val{cursor_byte_offset}
    }

    # create temp file to write to buffer, but only if buffer timestamp changed
    evaluate-commands -no-hooks %sh{
        if [ "$kak_timestamp" -gt "$kak_opt_tsobj_prev_timestamp" ] || [ ! -e "$kak_opt_tsobj_buf" ]; then
            printf 'set-option window tsobj_buf %s\n' "$(mktemp -q -t kak.tsobj.XXXXXXXX)"
            printf 'write -force %s\n' "%opt{tsobj_buf}"
            printf 'echo -debug "%s"\n' "created temp file %opt{tsobj_buf}"
            printf 'set-option buffer prev_timestamp %s\n' "$kak_timestamp"
        fi
    }

    # save selections to restore later if selection fails
    evaluate-commands -save-regs o %{
        execute-keys -draft <">oZ
        set-option window tsobj_selections %reg{o}
    }

    # run the query to try to get selections
    evaluate-commands -save-regs p %{
        try %{
            evaluate-commands %sh{
                # kak_selections_desc is used in script
                pipx run "$kak_opt_tsobj_script" $1 $2 $kak_object_flags $kak_select_mode $kak_opt_tsobj_offsets <"$kak_opt_tsobj_buf"
            }
        } catch %{
            set-register p %opt{tsobj_selections}
            execute-keys <">pz
        }
    }
}

map global object f '<a-semicolon>ts-objects-select %opt{filetype} function<ret>'  -docstring "tree-sitter function"
map global object c '<a-semicolon>ts-objects-select %opt{filetype} class<ret>'     -docstring "tree-sitter class"
map global object t '<a-semicolon>ts-objects-select %opt{filetype} test<ret>'      -docstring "tree-sitter test"
map global object m '<a-semicolon>ts-objects-select %opt{filetype} parameter<ret>' -docstring "tree-sitter parameter"
map global object o '<a-semicolon>ts-objects-select %opt{filetype} comment<ret>'   -docstring "tree-sitter comment"
map global object e '<a-semicolon>ts-objects-select %opt{filetype} entry<ret>'     -docstring "tree-sitter entry"
