function kak-grep
    kak -e "grep "(string join -- " " (string escape -- $argv))
end

alias kg kak-grep
complete -c kak-grep -w rg
