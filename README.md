# dotfiles

These are the configuration files for my work environment, where I use [fish
shell](https://fishshell.com), [Kakoune](https://kakoune.org) and
[Vim](https://www.vim.org) text editors, sometimes in
[tmux](https://github.com/tmux/tmux/wiki), in a Ubuntu or Debian native install
or [WSL](https://docs.microsoft.com/en-us/windows/wsl/about).

## Potentially interesting stuff
### fish
- [tmux shortcut](fish/functions/tm.fish) for launching or continuing sessions
  with tab-completion
- A [simplified pure-like prompt](fish/functions/fish_prompt.fish), with
  directories to ignore git prompt customizable with a `ignore_git` function

### Kakoune
- ~~[Kakoune version](kak/colors/mysticaltutor.kak) of
  [vim-mysticaltutor](https://github.com/caksoylar/vim-mysticaltutor)~~
  Colorscheme moved to [kakoune-mysticaltutor](https://github.com/caksoylar/kakoune-mysticaltutor)
- A lightweight [plugin cloner/updater](kak/kjp), adapted from [`vim-jetpack`](https://github.com/caksoylar/vim-jetpack)
- [Plugin](kak/autoload/gzip.kak) to edit gzipped files
- [Copy to clipboard](kak/autoload/clipboard.kak) using
  [OSC 52](https://discuss.kakoune.com/t/clipboard-integration-using-osc-52/)
- [Increment-decrement](kak/autoload/inc-dec.kak) like Vim's `<C-a>/<C-x>` and
  `g<C-a>/g<C-x>` in visual mode
- [A small utility](kak/autoload/ipynb.kak) to edit code blocks in ipynb
- [A most-recently-used files plugin](kak/autoload/mru.kak) like `mru.vim`, dependent
  on [`kakoune-state-save`](https://gitlab.com/Screwtapello/kakoune-state-save)

### Vim
- [Copy to clipboard](vim/vimrc#L165) using OSC 52
- [A small utility](vim/pack/self/start/vim-ipynb) to edit code blocks in ipynb
  files
- A basic [scrollbar-in-your-statusline
  implementation](vim/pack/self/start/scrollbar)
