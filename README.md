# dotfiles

These are the configuration files for my work environment, where I use [fish
shell](https://fishshell.com), [Kakoune](https://kakoune.org) and
[Vim](https://www.vim.org) text editors, sometimes in
[tmux](https://github.com/tmux/tmux/wiki), in a Ubuntu or Debian native install
or [WSL](https://docs.microsoft.com/en-us/windows/wsl/about). I also use an
[Iris keyboard](https://keeb.io/products/iris-keyboard-split-ergonomic-keyboard)
which is configured with [QMK](https://qmk.fm).

## Potentially interesting stuff
### fish
- [tmux shortcut](fish/functions/tm.fish) for launching or continuing sessions
  with tab-completion
- A [simplified pure-like prompt](fish/functions/fish_prompt.fish), with
  directories to ignore git prompt customizable with a `ignore_git` function

### Kakoune
- [A crude emulation](kak/kakrc#L39) of Vim cursorline
- [Kakoune version](kak/colors/mysticaltutor.kak) of
  [vim-mysticaltutor](https://github.com/caksoylar/vim-mysticaltutor)
- [Plugin](kak/autoload/gzip.kak) to edit gzipped files
- [Copy to clipboard](kak/autoload/clipboard.kak) for WSL and tmux

### Vim
- [A small utility](vim/pack/self/start/vim-ipynb) to edit code blocks in ipynb
  files
- A basic [scrollbar-in-your-statusline
  implementation](vim/pack/self/start/scrollbar)
