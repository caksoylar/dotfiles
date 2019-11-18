if executable('rls') && g:lsp_loaded
    setlocal omnifunc=lsp#complete
    augroup LspRust
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'rls',
                    \ 'cmd': {server_info->['rls']},
                    \ 'whitelist': ['rust']})
    augroup END
    call lsp#enable()
    call lspconfig#config()
endif
