" Vim filetype plugin file
" Language:	IMC Testcase file main.xml
" Maintainer:	Lin Bin Rocker <bin.rocker.liu@intel.com>
" Last Change:	Tue Jun 1 17:42:34 2012
" Version: 1.0
" Function: Vim syntax file for IMC chip level testcase file main.xml syntax 
"           highlight Normally, the main.xml is composed of several language 
"           part like C/Tcl/Perl

if exists("b:current_syntax")
   finish
endif

"highlight different syntax area 
"to adapt IMC testcase file main.xml
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction


call TextEnableCodeSnip('perl', '<PERL_POSTPROC>', '</PERL_POSTPROC>', 'SpecialComment')
call TextEnableCodeSnip('perl', '<PERL_PREPROC>', '</PERL_PREPROC>', 'SpecialComment')
call TextEnableCodeSnip('tcl', '<MS_TCL>', '</MS_TCL>', 'SpecialComment')
call TextEnableCodeSnip('c', '<ARM11_C>', '</ARM11_C>', 'SpecialComment')
call TextEnableCodeSnip('c', '<CA5_C>', '</CA5_C>', 'SpecialComment')
call TextEnableCodeSnip('c', '<CR5_C>', '</CR5_C>', 'SpecialComment')
call TextEnableCodeSnip('c', '<ARM_C>', '</ARM_C>', 'SpecialComment')
call TextEnableCodeSnip('c', '<LMT_C0>', '</LMT_C0>', 'SpecialComment')
call TextEnableCodeSnip('c', '<LMT_C1>', '</LMT_C1>', 'SpecialComment')
call TextEnableCodeSnip('c', '<TBIC>', '</TBIC>', 'SpecialComment')
call TextEnableCodeSnip('c', '<DPC_DSP0>', '</DPC_DSP0>', 'SpecialComment')
call TextEnableCodeSnip('c', '<RPCU_DSP0>', '</RPCU_DSP0>', 'SpecialComment')
call TextEnableCodeSnip('c', '<AUDIO_DSP0>', '</AUDIO_DSP0>', 'SpecialComment')
call TextEnableCodeSnip('c', '<AUDIO_DSP1>', '</AUDIO_DSP1>', 'SpecialComment')


let b:current_syntax = "imc_tc_mainxml"
