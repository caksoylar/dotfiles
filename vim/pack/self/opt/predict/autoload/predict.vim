" Location: autoload/predict.vim
" Author: Cem Aksoylar

if exists('g:autoloaded_predict')
  finish
endif
let g:autoloaded_predict = 1

let s:port_number = get(g:, 'predict_server_port', 8089)

" start server using jobs
function! predict#StartPredictServer() abort
    let server_command = get(g:, 'predict_server_command', 'none')
    if server_command ==# 'none'
        echoerr 'g:predict_server_command is not defined!'
        return 0
    endif
    let g:server_job = job_start(server_command,
                \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null', 'stoponexit': 'int'})
    if job_status(g:server_job) !=# 'run'
        return 0
    endif
    return 1
endfunction

" interact with server directly using channels
function! predict#SmartComplete(findstart, base) abort
    if a:findstart
        return col('.')
    endif

    " try to open channel if fails try to start server
    let channel = ch_open('localhost:' . s:port_number)
    if ch_status(channel) ==# 'fail'
        let success = predict#StartPredictServer()
        if !success
            echoerr 'could not start prediction server'
            return
        endif

        " give 1s for server to start
        let channel = ch_open('localhost:' . s:port_number, {'waittime': 1000})
    endif

    " get lines in buffer up to cursor
    let prev_lines = getline(1, line('.') - 1)
    let cur_line = getline('.')[:a:base - 1]
    let in_lines = prev_lines + [cur_line]

    " send lines along with filename to server
    let payload = {'filename': fnameescape(expand('%:p')), 'code': join(in_lines, "\n")}
    let response = ch_evalraw(channel, json_encode(payload), {'timeout': 10000})

    " decode the response to return list of predictions
    return json_decode(response)
endfunction
