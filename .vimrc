" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'

      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"==========================================================
 
" so far default changes.. do not touch the stuff above unless you are sure.

"additional changes:
set nu
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set nowrap
set smartcase
set hls "hlsearch, that is. 
set cindent
" Turn on syntax highlighting
syntax on

"inoremap { {}<left>
"inoremap ( ()<left> 

"EDIT FOR LATER		

"inoremap {<CR> {<CR>}<Esc>O
"inoremap {{ {
"inoremap {} {}

"inoremap (  ()<ESC>hli



"mapping the ESC key to k and j
inoremap jk <ESC>
inoremap kj <ESC>

"starting a new vim instance -- CTRL SHIFT n

map <C-S-n> :!start gvim<CR>


inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap { {<Cr>}<Esc>O

"dark mode

colorscheme slate
set guifont=Consolas:h15:cANSI:qDRAFT 

" automatically save before each make/execute command
set autowrite

" while typing a command, show it in the bottom right corner
set showcmd


set wildmenu            " visual autocomplete for command menu

" java specific code:

autocmd filetype java nnoremap <F5> :w <bar> !javac % && java -enableassertions %:r <CR>
