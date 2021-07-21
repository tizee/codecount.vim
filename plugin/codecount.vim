scriptencoding utf-8
if exists('loaded_codecount_vim') || &cp || v:version < 700
  finish
endif
let g:loaded_codecount_vim = 1

command! -nargs=* CodeCount call codecount#count(<q-args>)
