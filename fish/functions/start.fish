function start
    if test (count $argv) -eq 0
        set arg .
    else
        if test -d $argv[1]
            set arg $argv[1]
        else
            set arg (dirname $argv[1])
        end
    end
    /mnt/c/Windows/explorer.exe (wslpath -w $arg)
end
