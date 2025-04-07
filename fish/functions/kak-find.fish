function kak-find
    fd -L --type file $argv | xargs -d\n kak --
end

complete -c kak-find -w fd
