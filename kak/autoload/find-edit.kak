define-command find-edit -params 1 -shell-script-candidates 'fd --type file' 'edit %arg(1)'

map global user f ': find-edit ' -docstring 'find and edit file'
