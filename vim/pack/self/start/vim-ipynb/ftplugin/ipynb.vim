runtime! ftplugin/json.vim

setlocal formatprg=jq\ .

nnoremap <buffer> <Plug>(ipynb-edit-cell) :call ipynb#decode_json_string()<CR>
nmap <buffer> <CR> <Plug>(ipynb-edit-cell)
nmap <CR> <Plug>(ipynb-replace)
