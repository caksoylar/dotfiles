function lspconfig#config() abort
    " LSP config
    let g:lsp_diagnostics_echo_cursor = 1
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> K <Plug>(lsp-hover)
    nmap <buffer> gr <Plug>(lsp-references)
    nmap <buffer> gq <Plug>(lsp-document-format)
    xmap <buffer> gq <Plug>(lsp-document-format)
    nmap <buffer> <silent> <F9> :call lspconfig#diagnostics()<CR>
    nmap <buffer> ]r <Plug>(lsp-next-reference)
    nmap <buffer> [r <Plug>(lsp-previous-reference)

    hi! link LspErrorHighlight SpellBad
    hi! link LspWarningHighlight SpellRare
    hi! link LspHintHighlight SpellCap
endfunction

function lspconfig#diagnostics() abort
    silent! call lsp#ui#vim#diagnostics#document_diagnostics()
    cclose
    call setloclist(0, getqflist(), 'r')
    silent! colder
    lopen
endfunction
