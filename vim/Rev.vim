" Vim syntax file
" (Modified from R.vim)
" Language:	      Rev
" Maintainer:	      Michael Landis <jalvesaq@gmail.com>
" Filenames:	      *.Rev
" 

if exists("b:current_syntax")
  finish
endif

setlocal iskeyword=@,48-57,_,.

if exists("g:r_syntax_folding")
  setlocal foldmethod=syntax
endif

syn case match

" Comment
syn match revComment contains=@Spell "#.*"

" Roxygen
syn match revOKeyword contained "@\(param\|return\|name\|rdname\|examples\|include\)"
syn match revOKeyword contained "@\(S3method\|TODO\|aliases\|alias\|assignee\|author\|callGraphDepth\|callGraph\)"
syn match revOKeyword contained "@\(callGraphPrimitives\|concept\|exportClass\|exportMethod\|exportPattern\|export\|formals\)"
syn match revOKeyword contained "@\(format\|importClassesFrom\|importFrom\|importMethodsFrom\|import\|keywords\)"
syn match revOKeyword contained "@\(method\|nord\|note\|references\|seealso\|setClass\|slot\|source\|title\|usage\)"
syn match revOComment contains=@Spell,rOKeyword "#'.*"


if &filetype == "rhelp"
  " string enclosed in double quotes
  syn region revString contains=rSpecial,@Spell start=/"/ skip=/\\\\\|\\"/ end=/"/
  " string enclosed in single quotes
  syn region revString contains=rSpecial,@Spell start=/'/ skip=/\\\\\|\\'/ end=/'/
else
  " string enclosed in double quotes
  syn region revString contains=rSpecial,rStrError,@Spell start=/"/ skip=/\\\\\|\\"/ end=/"/
  " string enclosed in single quotes
  syn region revString contains=rSpecial,rStrError,@Spell start=/'/ skip=/\\\\\|\\'/ end=/'/
endif

syn match revStrError display contained "\\."


" New line, carriage return, tab, backspace, bell, feed, vertical tab, backslash
syn match revSpecial display contained "\\\(n\|r\|t\|b\|a\|f\|v\|'\|\"\)\|\\\\"

" Hexadecimal and Octal digits
syn match revSpecial display contained "\\\(x\x\{1,2}\|[0-8]\{1,3}\)"

" Unicode characters
syn match revSpecial display contained "\\u\x\{1,4}"
syn match revSpecial display contained "\\U\x\{1,8}"
syn match revSpecial display contained "\\u{\x\{1,4}}"
syn match revSpecial display contained "\\U{\x\{1,8}}"

" Statement
syn keyword revStatement   break next return
syn keyword revConditional if else
syn keyword revRepeat      for in repeat while

" Constant (not really)
syn keyword revConstant true false
syn keyword revNumber   NA_integer_ NA_real_ NA_complex_ NA_character_ 

" Constants
syn keyword revConstant NULL
syn keyword revBoolean  true false
syn keyword revNumber   NA Inf NaN 

" integer
syn match revInteger "\<\d\+L"
syn match revInteger "\<0x\([0-9]\|[a-f]\|[A-F]\)\+L"
syn match revInteger "\<\d\+[Ee]+\=\d\+L"

" number with no fractional part or exponent
syn match revNumber "\<\d\+\>"
" hexadecimal number 
syn match revNumber "\<0x\([0-9]\|[a-f]\|[A-F]\)\+"

" floating point number with integer and fractional parts and optional exponent
syn match revFloat "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="
" floating point number with no integer part and optional exponent
syn match revFloat "\<\.\d\+\([Ee][-+]\=\d\+\)\="
" floating point number with no fractional part and optional exponent
syn match revFloat "\<\d\+[Ee][-+]\=\d\+"

" operators
syn match revOperator    "&"
syn match revOperator    '-'
syn match revOperator    '*'
syn match revOperator    '+'
syn match revOperator    '='
if &filetype != "rmd" && &filetype != "rrst"
  syn match revOperator    "[|!<>^~/:]"
else
  syn match revOperator    "[|!<>^~`/:]"
endif
syn match revOperator    "%\{2}\|%\S*%"
syn match revOpError  '*\{3}'
syn match revOpError  '//'
syn match revOpError  '&&&'
syn match revOpError  '|||'
syn match revOpError  '<<'
syn match revOpError  '>>'

syn match revArrow "<\{1,2}-"
syn match revArrow "->\{1,2}"

" Special
syn match revDelimiter "[,;:]"

" Error
if exists("g:r_syntax_folding")
  syn region revRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,revError,revBraceError,revCurlyError fold
  syn region revRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,revError,revBraceError,revParenError fold
  syn region revRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,revError,revCurlyError,revParenError fold
else
  syn region revRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,revError,revBraceError,revCurlyError
  syn region revRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,revError,revBraceError,revParenError
  syn region revRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,revError,revCurlyError,revParenError
endif

syn match revError      "[)\]}]"
syn match revBraceError "[)}]" contained
syn match revCurlyError "[)\]]" contained
syn match revParenError "[\]}]" contained

" Source list of R functions. The list is produced by the Vim-R-plugin
" http://www.vim.org/scripts/script.php?script_id=2628
runtime r-plugin/functions.vim

syn match revDollar display contained "\$"
syn match revDollar display contained "@"

" List elements will not be highlighted as functions:
syn match revLstElmt "\$[a-zA-Z0-9\\._]*" contains=revDollar
syn match revLstElmt "@[a-zA-Z0-9\\._]*" contains=revDollar

" Functions that may add new objects
syn keyword revPreProc     library require attach detach source

if &filetype == "rhelp"
    syn match revHelpIdent '\\method'
    syn match revHelpIdent '\\S4method'
endif

" Type
syn keyword revType Real RealPos Integer Natural String Probability

" Name of object with spaces
if &filetype != "rmd" && &filetype != "rrst"
  syn region revNameWSpace start="`" end="`"
endif

if &filetype == "rhelp"
  syn match revhPreProc "^#ifdef.*" 
  syn match revhPreProc "^#endif.*" 
  syn match revhSection "\\dontrun\>"
endif

" RevBayes additions
" MJL 170510: The proper way to do this would be to load in a list of keywords
"             supplied dynamically from RevBayes through the `ls(true)`
"             listing, and retrieved a vim plugin and the `runtime` command.
syn match revDistribution "dn[A-Z][a-zA-Z0-9]*"
syn match revMove         "mv[A-Z][a-zA-Z0-9]*"
syn match revMonitor      "mn[A-Z][a-zA-Z0-9]*"
syn match revFunction     "fn[A-Z][a-zA-Z0-9]*"
syn keyword revProcedure mcmc model readTrees readDiscreteCharacterData readContinuousCharacterData readDataDelimitedFile


" Define the default highlighting.
hi def link revDistribution Function
hi def link revMove        Function
hi def link revMonitor     Function
hi def link revFunction    Function
hi def link revProcedure   Function
hi def link revArrow       Statement	
hi def link revBoolean     Boolean
hi def link revBraceError  Error
hi def link revComment     Comment
hi def link revOComment    Comment
hi def link revComplex     Number
hi def link revConditional Conditional
hi def link revConstant    Constant
hi def link revCurlyError  Error
hi def link revDelimiter   Delimiter
hi def link revDollar      SpecialChar
hi def link revError       Error
hi def link revFloat       Float
hi def link revFunction    Function
hi def link revHelpIdent   Identifier
hi def link revhPreProc    PreProc
hi def link revhSection    PreCondit
hi def link revInteger     Number
hi def link revLstElmt	 Normal
hi def link revNameWSpace  Normal
hi def link revNumber      Number
hi def link revOperator    Operator
hi def link revOpError     Error
hi def link revParenError  Error
hi def link revPreProc     PreProc
hi def link revRepeat      Repeat
hi def link revSpecial     SpecialChar
hi def link revStatement   Statement
hi def link revString      String
hi def link revStrError    Error
hi def link revType        Type
hi def link revOKeyword    Title

let b:current_syntax="Rev"

" vim: ts=8 sw=2
