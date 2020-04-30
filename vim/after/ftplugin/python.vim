if executable('pyls') && g:lsp_loaded
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'pyls',
                    \ 'cmd': {server_info->['pyls']},
                    \ 'whitelist': ['python'],
                    \ 'workspace_config': {'pyls': {'plugins': {'pycodestyle': {'maxLineLength': 160}}}}})
    augroup END
    call lsp#enable()
endif
setlocal makeprg=pylint\ -d\ C0111,C0301,C0103,E1101\ --output-format=parseable\ %:p
setlocal errorformat=%f:%l:\ %m
