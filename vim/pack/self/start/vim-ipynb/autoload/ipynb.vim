function ipynb#decode_json_string() abort
    let s:ipynb_buf = bufname("%") 
    let s:ipynb_line = line(".") 
    let wrapped = '{"text": ' . getline('.') . '}'
    let decoded = json_decode(wrapped)["text"]
    new
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    setfiletype python
    nnoremap <buffer> <Plug>(ipynb-replace) :call ipynb#replace_json_string()<CR>
    " autocmd BufWriteCmd <buffer> call ipynb#replace_json_string()
    call setline(1, split(decoded, "\n"))
endfunction

function ipynb#replace_json_string() abort
    let wrapped = {"text": join(getline(1, "$"), "\n")}
    let @j = matchlist(json_encode(wrapped), '\v:\s*"(.*)"')[1]
    quit
    execute "buffer " . s:ipynb_buf
    execute s:ipynb_line
    norm! vi""jp
endfunction
