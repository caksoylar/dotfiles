# copied from https://github.com/mawww/config/blob/604ef1c1c2f4722505d3d29a4fc95e763a1fddbb/kakrc#L196
define-command diff-buffers -override -params 2 %{
    evaluate-commands %sh{
        file1=$(mktemp)
        file2=$(mktemp)
        echo "
            evaluate-commands -buffer '$1' write -force $file1
            evaluate-commands -buffer '$2' write -force $file2
            edit! -scratch *diff-buffers*
            set buffer filetype diff
            set-register | 'diff -u $file1 $file2; rm $file1 $file2'
            execute-keys !<ret>gg
        "
}}

complete-command diff-buffers buffer
