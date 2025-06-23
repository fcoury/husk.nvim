" Vim syntax file
" Language:     Husk
" Maintainer:   Felipe Coury
" Last Change:  2025

" if exists("b:current_syntax")
"   finish
" endif

" Allow for nesting of syntax regions
syn sync fromstart

" --- Literals ---
syn keyword huskBoolean      true false
syn region  huskString       start='"' skip='\\"' end='"'
syn match   huskNumber       '\<\d\+\>'
syn match   huskFloat        '\<\d\+\.\d*\>'

" --- Keywords and Types ---
syn keyword huskKeyword      let fn struct enum impl if else match for while loop break continue return self use
syn keyword huskType         int float bool string
syn keyword huskBuiltIn      println

" --- Operators ---
syn match huskOperator           '[+\-*/%]='
syn match huskOperator           '[+\-*/%]'
syn match huskComparisonOperator '[<>]=?'
syn match huskComparisonOperator '[!=]='
syn match huskLogicalOperator    '&&\|||'
syn match huskLogicalOperator    '!'
syn match huskRangeOperator      '\.\.=\?'

" --- Identifiers and Accessors ---
syn match huskFunction     '\<\w\+\ze\s*('
syn match huskStructField  '\.\s*\zs\w\+'
syn match huskEnumVariant  '\<[A-Z]\w*\ze\s*::'
syn match huskEnumAccess   '::\s*\zs\w\+'
syn match huskReturnType   '->\s*\zs\w\+'

" --- Structure Definitions ---
syn match huskStructDef      'struct\s\+\w\+' contains=huskKeyword
syn match huskEnumDef        'enum\s\+\w\+'   contains=huskKeyword
syn match huskTypeAnnotation ':\s*\zs\w\+'

" --- Regions (Complex Structures) ---

" An @huskExpression cluster groups all elements that can be part of an expression.
" This is more robust and performant than using 'contains=ALL'.
syn cluster huskExpression contains=huskBoolean,huskString,huskNumber,huskFloat,huskFunction,huskStructField,huskEnumVariant,huskEnumAccess,huskOperator,huskComparisonOperator,huskLogicalOperator,huskRangeOperator,huskBuiltIn,huskType

" 'use' statements
syn match huskUseKeyword '\<use\>'      contained
syn match huskPath       '\<\w\+\(::\w\+\)*' contained
syn match huskLocalPath  '\<local\(::\w\+\)*'  contained
syn region huskUseStatement start='^\s*use\>' end=';' contains=huskUseKeyword,huskPath,huskLocalPath,@huskCommentGroup

" Function signatures
syn region huskFunctionSignature start='fn\s\+\w\+\s*(' end=')' contains=huskKeyword,huskTypeAnnotation,huskIdentifier,@huskCommentGroup

" Struct and enum bodies
syn region huskStructBlock start='{' end='}' transparent contained contains=huskIdentifier,huskTypeAnnotation,@huskCommentGroup

" Match arms
syn region huskMatchArm start='=>' end='[,}]' keepend contains=@huskExpression,@huskCommentGroup,huskStructBlock

" --- Highlight Linking ---
" Link the syntax groups defined above to standard Vim highlight groups.
hi def link huskKeyword            Keyword
hi def link huskType               Type
hi def link huskBuiltIn            Special
hi def link huskBoolean            Boolean
hi def link huskLineComment        Comment
hi def link huskBlockComment       Comment
hi def link huskString             String
hi def link huskNumber             Number
hi def link huskFloat              Float
hi def link huskFunction           Function
hi def link huskStructField        Identifier
hi def link huskEnumVariant        Type
hi def link huskEnumAccess         Identifier
hi def link huskOperator           Operator
hi def link huskComparisonOperator Operator
hi def link huskLogicalOperator    Operator
hi def link huskRangeOperator      Operator
hi def link huskTypeAnnotation     Type
hi def link huskReturnType         Type
hi def link huskStructDef          Structure
hi def link huskEnumDef            Structure
hi def link huskUseKeyword         Keyword
hi def link huskPath               Include
hi def link huskLocalPath          Include

" --- Comments ---
" Define comments first so they can be included in other syntax groups.
syn match huskLineComment   "\/\/.*$" contains=@Spell
syn region huskBlockComment  start="/\*" end="\*/" contains=@Spell
syn cluster huskCommentGroup contains=huskLineComment,huskBlockComment

let b:current_syntax = "husk"
