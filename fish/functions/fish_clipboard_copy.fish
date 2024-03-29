function fish_clipboard_copy
    # Copy the current selection, or the entire commandline if that is empty.
    set -l cmdline (commandline --current-selection)
    test -n "$cmdline"; or set cmdline (commandline)
    printf "\e]52;;%s\e\\" (printf '%s\n' $cmdline | perl -0777 -pe 's/\n$//' | base64 -w 0 -) >/dev/tty
    if type -q pbcopy
        printf '%s\n' $cmdline | pbcopy
    else if type -q clip.exe
        printf '%s\n' $cmdline | clip.exe
    else if type -q xsel
        # Silence error so no error message shows up
        # if e.g. X isn't running.
        printf '%s\n' $cmdline | xsel --clipboard 2>/dev/null
    else if type -q xclip
        printf '%s\n' $cmdline | xclip -selection clipboard 2>/dev/null
    else if type -q wl-copy
        printf '%s\n' $cmdline | wl-copy
    end
end
