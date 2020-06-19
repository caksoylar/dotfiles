function lspconfig#config() abort
    " LSP config
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> K <Plug>(lsp-hover)
    nmap <buffer> gr <Plug>(lsp-references)
    nmap <buffer> gq <Plug>(lsp-document-format)
    xmap <buffer> gq <Plug>(lsp-document-format)
    nmap <buffer> <F9> <Plug>(lsp-document-diagnostics)
    nmap <buffer> ]r <Plug>(lsp-next-reference)
    nmap <buffer> [r <Plug>(lsp-previous-reference)

    hi! link LspErrorHighlight SpellBad
    hi! link LspWarningHighlight SpellRare
    hi! link LspHintHighlight SpellCap
endfunction
