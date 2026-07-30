function kak-grep-git
    set -l grepargs
    for x in $argv
        set -a grepargs (echo $x | sed -e "s/'/''/g" -e "s/^/'/" -e "s/\$/'/")
    end
    set -l fileargs
    for x in (git ls-files)
        set -a fileargs (echo $x | sed -e "s/'/''/g" -e "s/^/'/" -e "s/\$/'/")
    end
    kak -e "grep -0 $(string join -- " " $grepargs) -- $(string join -- " " $fileargs)"
end
