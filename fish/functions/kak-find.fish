function kak-find
    fd -L --type file $argv | xargs kak --
end

complete -c kak-find -w fd
