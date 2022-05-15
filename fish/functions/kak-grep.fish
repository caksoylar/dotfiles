function kak-grep
    set -l grepargs
    for x in $argv
        set -a grepargs (echo $x | sed -e "s/'/''/g" -e "s/^/'/" -e "s/\$/'/")
    end
    kak -e "grep $(string join -- " " $grepargs)"
end

complete -c kak-grep -w rg
