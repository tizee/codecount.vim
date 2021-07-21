scriptencoding utf-8

let s:WinManger = {}
let g:CodeCountWinManager = s:WinManger 

function! codecount#count(...) abort
  let path=expand("%:p:h")
  if a:0 > 0
    let path = a:1
  endif 
  let output=system('cloc --quiet ' . path)
  call g:CodeCountWinManager.createSplit()
  call s:render(output)
endfunction

function! s:render(output)
  " render output in current buffer
  setl noreadonly modifiable
  let curLine = line('.')
  let curCol = col('.')

  silent 1,$delete _
  silent! put =a:output
  " delete the blank line at the top of the buffer
  silent 1,1delete _

  call cursor(curLine, curCol)
  setl readonly nomodifiable
endfunction

function! s:WinManger.createSplit()
  " default split a window at the bottom
  let splitPosition=get(g:,"codeCountSplitPos", "bo")
  " 20% of current screen view
  let splitSize=get(g:,"codeCountWinSize", 20)
  let t:CodeCountBufferName = "CodeCountBuffer__output"
  " create buffer window
  silent! execute splitPosition . " split " . splitSize . ' new'
  " rename
  silent! execute "edit " . t:CodeCountBufferName
  " set to fixed height
  silent! execute "resize " . splitSize
  setlocal winfixwidth
  setlocal winfixheight

  " set local options
  setl buftype=nofile
  setl bufhidden=hide
  setl noswapfile
  setl nobuflisted
  setl nofoldenable
  setl nolist
  setl nospell
  setl nowrap
  setl filetype=codecount
endfunction
