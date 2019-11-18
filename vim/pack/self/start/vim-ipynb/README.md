# vim-ipynb

This is a simple plugin to allow editing ipynb (Jupyter) notebook cells
directly. Right now it requires the cell to consist of only one item with
`"text"` key and the value on a single line. Then pressing `<CR>` (enter) on
that line opens a new split that you can edit. Pressing enter in that split
applies your changes to the notebook directly.

It also sets `formatprg` to `jq` which you can use with `gq`, along with proper
syntax and indent configuration for json.
