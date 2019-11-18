" Location: plugin/predict.vim
" Author: Cem Aksoylar

if exists('g:loaded_predict') || v:version < 800 || &compatible
    finish
endif
let g:loaded_predict = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

" enable predicter for python as user completer
augroup Predict
    autocmd!
    autocmd FileType python set completefunc=predict#SmartComplete
augroup END

let &cpoptions = s:save_cpo
