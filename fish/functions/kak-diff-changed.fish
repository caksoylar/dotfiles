function kak-diff-changed
    git diff -z --name-only --line-prefix=(git rev-parse --show-toplevel)/ $argv | xargs -0 kak --
end

complete -c kak-diff-changed -w git-diff
