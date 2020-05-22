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
- [Kakoune version](kak/colors/mysticaltutor.kak) of
  [vim-mysticaltutor](https://github.com/caksoylar/vim-mysticaltutor)
- [Plugin](kak/autoload/gzip.kak) to edit gzipped files
- [Copy to clipboard](kak/autoload/clipboard.kak) using OSC 52
- [Increment-decrement](kak/autoload/inc-dec.kak) like Vim's `<C-a>/<C-x>` and
  `g<C-a>/g<C-x>` in visual mode
- [A crude emulation](kak/autoload/cursorline.kak) of Vim cursorline
- [A small utility](kak/autoload/ipynb.kak) to edit code blocks in ipynb
  files

### Vim
- [Copy to clipboard](vim/vimrc#L165) using OSC 52
- [A small utility](vim/pack/self/start/vim-ipynb) to edit code blocks in ipynb
  files
- A basic [scrollbar-in-your-statusline
  implementation](vim/pack/self/start/scrollbar)

### QMK
- A ["tmux" layer](qmk/keymap.c#L83) which sends a prefix before any pressed key
