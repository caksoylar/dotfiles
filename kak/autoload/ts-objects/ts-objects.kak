declare-option -hidden int-list tsobj_offsets
declare-option -hidden str tsobj_buf
declare-option -hidden str-list tsobj_selections
declare-option -hidden int tsobj_prev_timestamp 0
declare-option -hidden str tsobj_script %sh{printf "%s/kts.py" "$(dirname "$kak_source")"}  # python script path

define-command ts-objects-select -params 3 %{
    set-option window tsobj_offsets
    evaluate-commands -itersel %{
        set-option -add window tsobj_offsets %val{cursor_byte_offset}
    }

    evaluate-commands -no-hooks %sh{
        if [ "$kak_timestamp" -gt "$kak_opt_tsobj_prev_timestamp" ] || [ ! -e "$kak_opt_tsobj_buf" ]; then
            printf 'set-option window tsobj_buf %s\n' "$(mktemp -q -t kak.tsobj.XXXXXXXX)"
            printf 'write -force %s\n' "%opt{tsobj_buf}"
            printf 'echo -debug "%s"\n' "created temp file %opt{tsobj_buf}"
            printf 'set-option buffer prev_timestamp %s\n' "$kak_timestamp"
        fi
    }

    evaluate-commands -save-regs o %{
        execute-keys -draft <">oZ
        set-option window tsobj_selections %reg{o}
    }

    evaluate-commands -save-regs p %{
        try %{
            echo -debug %sh{
                echo pipx run "$kak_opt_tsobj_script" $1 $2 $3 $kak_opt_tsobj_offsets '<'"$kak_opt_tsobj_buf"
            }
            evaluate-commands %sh{
                pipx run "$kak_opt_tsobj_script" $1 $2 $3 $kak_opt_tsobj_offsets <"$kak_opt_tsobj_buf"
            }
        } catch %{
            set-register p %opt{tsobj_selections}
            execute-keys <">pz
        }
    }
}

declare-user-mode ts-objects
map global ts-objects f ':ts-objects-select %opt{filetype} function inside<ret>'  -docstring "function inside"
map global ts-objects F ':ts-objects-select %opt{filetype} function around<ret>'  -docstring "function around"
map global ts-objects c ':ts-objects-select %opt{filetype} class inside<ret>'     -docstring "class inside"
map global ts-objects C ':ts-objects-select %opt{filetype} class around<ret>'     -docstring "class around"
map global ts-objects t ':ts-objects-select %opt{filetype} test inside<ret>'      -docstring "test inside"
map global ts-objects T ':ts-objects-select %opt{filetype} test around<ret>'      -docstring "test around"
map global ts-objects p ':ts-objects-select %opt{filetype} parameter inside<ret>' -docstring "parameter inside"
map global ts-objects o ':ts-objects-select %opt{filetype} comment inside<ret>'   -docstring "comment inside"
map global ts-objects O ':ts-objects-select %opt{filetype} comment around<ret>'   -docstring "comment around"
map global ts-objects e ':ts-objects-select %opt{filetype} entry inside<ret>'     -docstring "entry inside"
map global ts-objects E ':ts-objects-select %opt{filetype} entry around<ret>'     -docstring "entry around"
