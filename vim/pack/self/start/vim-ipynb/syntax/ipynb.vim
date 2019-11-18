if exists("b:current_syntax")
    finish
endif

runtime! syntax/json.vim

let b:current_syntax = "ipynb"
