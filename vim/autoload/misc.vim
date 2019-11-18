function misc#toggle_diff() abort
    if &diff
        windo diffoff
    elseif winnr('$') == 2
        windo diffthis
    else
        vsplit | buffer # | windo diffthis
    endif
endfunction

function misc#place_sign(named) abort
    if a:named
        let l:charnr = getchar()
        if l:charnr >= 65 && l:charnr <= 122
            let l:char = nr2char(l:charnr)
            let l:id = 1000 + l:charnr
            call sign_unplace('marks', {'id': l:id, 'buffer': bufnr('')})
            call sign_define('m' . l:char, {'text': l:char, 'texthl': 'Todo'})
            call sign_place(l:id, 'marks', 'm' . l:char, bufnr(''), {'lnum': line('.')})
            execute "normal! m" . l:char
        endif
    else
        call sign_define('custom', {'text': '>', 'texthl': 'Todo'})
        let b:sign_id = getbufvar('', 'sign_id', 0) + 1
        call sign_place(b:sign_id, 'custom', 'custom', bufnr(''), {'lnum': line('.')})
    endif
endfunction

function misc#remove_signs() abort
    call sign_unplace('*', {'buffer': bufnr('')})
endfunction

function misc#redir(cmd) abort
    if a:cmd =~ '^!'
        let output = system(substitute(a:cmd, '^!', '', ''))
    else
        redir => output
        execute a:cmd
        redir END
    endif
    new
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output, "\n"))
endfunction

function misc#align_buffer(char) abort
    let w:pos = winsaveview()
    execute "normal ggglG" . a:char
    call winrestview(w:pos)
endfunction

function misc#MRU() abort
    enew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, v:oldfiles)
    nnoremap <silent> <buffer> <CR> :keepalt edit <C-r><C-l><CR>
endfunction

function misc#hl_yank() abort
    let [sl, el, sc, ec] = [line("'["), line("']"), col("'["), col("']")]
    if sl == el
        let pos_list = [[sl, sc, ec - sc + 1]]
    else
        let pos_list = [[sl, sc, col([sl, "$"]) - sc]] + range(sl + 1, el - 1) + [[el, 1, ec]]
    endif

    for chunk in range(0, len(pos_list), 8)
        call matchaddpos('IncSearch', pos_list[chunk:chunk + 7])
    endfor
    redraw!
    call timer_start(500, {t_id -> clearmatches()})
endfunction
