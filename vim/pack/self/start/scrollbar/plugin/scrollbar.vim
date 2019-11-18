" Location: plugin/scrollbar.vim
" Author: Cem Aksoylar

scriptencoding utf-8

if exists('g:loaded_scrollbar') || v:version < 800 || &compatible
    finish
endif
let g:loaded_scrollbar = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:width  = get(g:, "scrollbar_width", 8)
let s:bars   = get(g:, "scrollbar_bars", "░▒▓█")
let s:barlen = strchars(s:bars)
let s:full   = repeat(nr2char(strgetchar(s:bars, s:barlen - 1)), s:width)
let s:empty  = repeat(" ", s:width)

function! s:Stl_P() abort
    let above = line('w0') - 1
    let below = line('$') - line('w$')
    if below <= 0
        return -2
    elseif above <= 0
        return -1
    else
        return above * s:width * s:barlen / (above + below)
    endif
endfunction

function! Scrollbar()
    let p = s:Stl_P()
    if p == -1
        return s:empty
    elseif p <= -2
        return s:full
    else
        return printf("%-" . s:width . "S", strcharpart(s:full, 0, p / s:barlen) . strcharpart(s:bars, p % s:barlen - 1, 1))
    endif
endfunction

let &cpoptions = s:save_cpo
