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
setlocal makeprg=pylint\ -d\ C0111\ -d\ C0301\ -d\ C0103\ -d\ E1101\ --output-format=parseable\ %:p
setlocal errorformat=%f:%l:\ %m
