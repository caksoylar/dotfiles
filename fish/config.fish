set fish_greeting
if type -q kak
    set EDITOR kak
else
    set EDITOR vim
end

# add user bin and lib paths
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

# remove Windows paths
set PATH (string split $PATH | grep -v '^/mnt/')

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

alias rm="rm -I"
alias sort="sort -S4G"
alias start="/mnt/c/Windows/explorer.exe"
alias clip.exe="/mnt/c/Windows/System32/clip.exe"

# some tmux shortcuts in addition to tm.fish
alias tl="tmux list-sessions"
alias ta="tmux attach-session"

# fugitive
alias gst="vim '+G | only'"

# old-style highlighting
set fish_color_normal normal
set fish_color_command --bold
set fish_color_param cyan
set fish_color_redirection brblue
set fish_color_comment red
set fish_color_error brred
set fish_color_escape bryellow --bold
set fish_color_operator bryellow
set fish_color_end brmagenta
set fish_color_quote yellow
set fish_color_autosuggestion 555 brblack
set fish_color_user brgreen

# work stuff
if test -f ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end
