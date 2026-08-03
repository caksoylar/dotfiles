function kak-grep-git
    set -l grepargs
    for x in $argv
        set -a grepargs (echo $x | sed -e "s/'/''/g" -e "s/^/'/" -e "s/\$/'/")
    end
    kak -e "set-option global grepcmd 'git grep -n --column'; grep $(string join -- " " $grepargs)"
end
