
"colorscheme
colorscheme desert
"colorscheme leo
"colorscheme desertEx

"auto syntax
syntax on

"language
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set textwidth=0
set modifiable

"confirm for the readonly/unsaved files when exit
set confirm

"TAB key option
set smarttab
set tabstop=2
set softtabstop=2 "available for backspace
set shiftwidth=2 
set expandtab "to expand all TABs as SPACEs

" set mapleader
let mapleader = ","

"syntax match
set showmatch
set matchtime=2

"filetype, 'indent on' is necessary for smartindent
filetype on
filetype plugin on
filetype indent on

"indent
set smartindent
set autoindent

"command
set cmdheight=2
set laststatus=2

"search option
set hlsearch
set incsearch 
set ignorecase
"set ignorecase smartcase 

"line number
set number 

set nocompatible

"cursor state
set ruler

"the edge off the buffer
set scrolloff=3

"enable the backspace deletion space up to 2 lines
set backspace=2

"No automatic backup files
set nobackup

"Fold method
set foldmethod=marker " for SV
"set foldmethod=syntax " for C/C++

"Find a selected string area similar with searching word
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

"Mouse could be controled when INSERT model
"set mouse=a
"set selection=exclusive
"set selectmode=mouse,key

"Font type and size
"set guifont=monospace\ 15.5
set guifont=courier\ 10\ pitch\ 15.5

"Hot key for MS control

"Windows control
nmap wn <C-w>n
nmap wv <C-w>v
nmap wc <C-w>c 
nmap ws <C-w>s

"tag view control
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>

"ignore the full path of tags
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel()}

"Grep hot key
nnoremap <silent><F3> :Grep<CR>


" this abbreviation %% expands to the full path of the directory that contains
" the current file. For example, while editing file /some/path/myfile.txt,
" typing: e %%/ on the command line will expand to :e /some/path/.
cabbr <expr> %% expand('%:p:h') 


"Create brackets
"inoremap ( () <ESC> i
"inoremap [ [] <ESC> i
"inoremap { {} <ESC> i

"Hot key for comments
ab ccc   //-----------------------------------------------------------------------------------
ab ccl*  *************************************************************************************
ab ccl=  =====================================================================================
ab ccl#  #------------------------------------------------------------------------------------
ab ccl+  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ab ccl-  -------------------------------------------------------------------------------------
ab ccs   //-------------------------------------
ab cc+   +++++++++++++++++++++++++++++++++++++++
ab cc=   =======================================
ab cc*   ***************************************
ab cc-   ---------------------------------------
ab cc#   #--------------------------------------

"Self-defined function Cnt_match to count and show the matched search_wd
function Cnt_match(search_wd)
   let cnt = 0 
   let i = 1 
   let cur_line = line(".")
   normal G
   let last_lie = line(".")
   echo "Searching ... " a:search_wd

   normal gg

   while search(a:search_wd,"W") > 0 
      echo "Yes ... Line".line(".")."  >::>::>".getline(".")
      let cnt = cnt + 1
   endwhile


   echo "Match Counter : ". cnt
   execute cur_line
endfunction

"Self-defined function Clum_i to insert number to signal list
"This is helpful to name huge signal list with number
function Clum_i(start,end,span)
   let cnt = a:start
   let line_num = line(".")
   let clum_num = col(".")

   while cnt <= a:end
      execute "normal i".cnt."\<ESC>"
      let line_num = line_num + a:span + 1 
      call cursor(line_num,clum_num)
      let cnt = cnt + 1
   endwhile
endfunction;


"Config for treeExplorer plugin
let g:treeExplVertical=1
let g:treeExplDirSort=1
let g:treeExplWinSize=30
nmap vt :VSTreeExplore<cr>

"Config for miniBuffer plugin
"let g:miniBufExplVSplit = 20   " column width in chars
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 
"let g:miniBufExplSplitToEdge = 0


"Config for winManager plugin
let g:winManagerWidth=20
nmap wm :WMToggle<cr> 
let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
"let g:winManagerWindowLayout = 'FileExplorer|BufExplorer'
"let g:winManagerAutoOpen=1

"Config for Tlist plugin
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let g:Tlist_Use_Right_Window=1
"let g:Tlist_Auto_Open=1
let g:Tlist_Show_One_File=1
"let g:Tlist_Compact_Format=1
"let g:Tlist_Use_SingleClick=1
"let g:Tlist_Enable_Fold_Column=0

"=============================
" showmarks setting
"=============================
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 
hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black 

"=============================
" markbrowser setting
"=============================
nmap <silent> <leader>mk :MarksBrowser<cr> 

"=============================
" main.xml syntax setting
"=============================


