if executable('cquery') && g:lsp_loaded
    augroup LspCpp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'cquery',
                    \ 'cmd': {server_info->['cquery']},
                    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
                    \ 'initialization_options': {'cacheDirectory': '/tmp/cquery'},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc']})
    augroup END
    call lsp#enable()
endif
