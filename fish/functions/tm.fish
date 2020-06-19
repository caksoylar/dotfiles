function tm
    if test (count $argv) -eq 0
        set session "main"
    else
        set session $argv[1]
    end
    tmux new-session -A -s "$session" $argv[2..-1]
end
complete -c tm -f -a "(tmux list-sessions -F '#{session_name}'\t'#{session_windows} windows (last attached #{t:session_last_attached})')"
