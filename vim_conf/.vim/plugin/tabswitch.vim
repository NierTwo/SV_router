" Mini Buffer Explorer <minibufexpl.vim>
"
" HINT: Type zR if you don't know how to use folds
"
" Has this plugin already been loaded? {{{
"
if exists('loaded_tabswitch')
  finish
endif
let loaded_tabswitch = 1
" }}}

" Global Configuration Variables
"
" Extended window navigation commands? {{{
  noremap <C-J> <C-W>j
  noremap <C-K> <C-W>k
  noremap <C-H> <C-W>h
  noremap <C-L> <C-W>l

  noremap <C-Down>  <C-W>j
  noremap <C-Up>    <C-W>k
  noremap <C-Left>  <C-W>h
  noremap <C-Right> <C-W>l

" in the current window then perform the remapping
"
  noremap <C-RETURN>   :call <SID>CycleBuffer(1)<CR>:<BS>
  noremap <C-TAB>   :call <SID>CycleBuffer(1)<CR>:<BS>
  noremap <C-S-RETURN>   :call <SID>CycleBuffer(0)<CR>:<BS>
  noremap <C-S-TAB> :call <SID>CycleBuffer(0)<CR>:<BS>

" }}}

" CycleBuffer - Cycle Through Buffers {{{
"
" Move to next or previous buffer in the current window. If there 
" are no more modifiable buffers then stay on the current buffer.
" can be called with no parameters in which case the buffers are
" cycled forward. Otherwise a single argument is accepted, if 
" it's 0 then the buffers are cycled backwards, otherwise they
" are cycled forward.
"
function! <SID>CycleBuffer(forward)
  " Change buffer (keeping track of before and after buffers)
  let l:origBuf = bufnr('%')
  if (a:forward == 1)
    bn!
  else
    bp!
  endif
  let l:curBuf  = bufnr('%')

  " Skip any non-modifiable buffers, but don't cycle forever
  " This should stop us from stopping in any of the [Explorers]
  while getbufvar(l:curBuf, '&modifiable') == 0 && l:origBuf != l:curBuf
    if (a:forward == 1)
        bn!
    else
        bp!
    endif
    let l:curBuf = bufnr('%')
  endwhile

endfunction

" vim:ft=vim:fdm=marker:ff=unix:nowrap:tabstop=4:shiftwidth=4:softtabstop=4:smarttab:shiftround:expandtab
