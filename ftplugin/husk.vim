" Vim filetype plugin file
" Language:     Husk
" Maintainer:   Felipe Coury
" Last Change:  2025

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Indentation: 4 spaces, no tabs
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" Set comment string
setlocal commentstring=//\ %s

" Set 'formatoptions' to break comment lines but not other lines
setlocal formatoptions-=t formatoptions+=croql

" Match words with underscores
setlocal iskeyword+=_

" Set path for gf and similar commands to work with use statements
setlocal path+=.,src/**,tests/**

" Basic folding support
setlocal foldmethod=syntax
setlocal foldlevel=99

" Match pairs for % command
setlocal matchpairs+=<:>

" Format on save (disable with: let g:husk_format_on_save = 0)
if !exists("g:husk_format_on_save")
  let g:husk_format_on_save = 1
endif

function! s:HuskFormat()
  if !g:husk_format_on_save
    return
  endif

  " Save cursor position and view
  let l:view = winsaveview()

  " Run huskc fmt on the current file
  let l:output = system('huskc fmt ' . shellescape(expand('%:p')))

  " Check for errors
  if v:shell_error != 0
    " Don't reload if formatter failed
    echohl WarningMsg
    echo "huskc fmt failed: " . l:output
    echohl None
    return
  endif

  " Reload the file to get formatted content
  silent edit!

  " Restore cursor position and view
  call winrestview(l:view)
endfunction

" Format command
command! -buffer HuskFmt call s:HuskFormat()

" Auto-format on save
augroup husk_format
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> call s:HuskFormat()
augroup END
