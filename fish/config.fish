set fish_greeting
if type -q kak
    set EDITOR kak
else
    set EDITOR vim
end

# add user bin, lib and man paths
for dir in ~/miniconda3/bin ~/.cargo/bin ~/.local/bin ~/bin
    if test -d $dir; and not contains $dir $PATH
        set PATH $dir $PATH
    end
end

for dir in ~/.local/lib ~/lib
    if test -d $dir; and not contains $dir $LD_LIBRARY_PATH
        set LD_LIBRARY_PATH $dir
    end
end

# for dir in ~/.local/share/man ~/man
#     if test -d $dir; and not contains $dir $MANPATH
#         set MANPATH $dir
#     end
# end

# vim for manpager
function vman
    man $argv | col -b | vim --clean -c 'runtime! macros/less.vim' -c 'set ft=man ic' --not-a-term -
end

# more legible symlink folder highlighting
set -x LS_COLORS "ow=01;34"

# function fish_user_key_bindings
    # bind --erase \cx
    # bind --erase \cv
# end

# fix conda venv
if type -q conda >/dev/null
    source (conda info --root)/etc/fish/conf.d/conda.fish
end

# trapd00r/LS_COLORS
if test -f ~/.config/fish/LS_COLORS
    eval (dircolors -c ~/.config/fish/LS_COLORS)
end

# aliases (not necessarily all interactive use)
if not type -q fd
    alias fd "fdfind"
end
alias sort "sort -S4G"
alias clip.exe "/mnt/c/Windows/System32/clip.exe"
alias dc "echo 1 | sudo tee /proc/sys/vm/drop_caches"
alias glow "glow -pw (tput cols)"
alias pact "eval (poetry env activate)"

# abbreviations (for interactive use)
abbr --add k kak
abbr --add g git
abbr --add rm "rm -I"
abbr --add lt "ll -t"
abbr --add kg kak-grep
abbr --add kf kak-find

# some tmux shortcuts in addition to tm.fish
abbr --add tl "tmux list-sessions"
abbr --add ta "tmux attach-session"

# fugitive
abbr --add gst "vim '+G | only'"

# old-style highlighting
fish_config theme choose termcolors

abbr --add mm micromamba

# work stuff
if test -f ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end
