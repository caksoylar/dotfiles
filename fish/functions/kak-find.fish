function kak-find
    fd -LF --type file $argv | xargs kak --
end

complete -c kak-find -w fd
