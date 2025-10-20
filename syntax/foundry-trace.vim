if exists("b:current_syntax")
  finish
endif

" Foundry traces are pretty case-insensitive for hex/addresses
syn case ignore

" ──────────────────────────────────────────────────────────────────────────────
" Core tokens
" ──────────────────────────────────────────────────────────────────────────────

" Box drawing / tree branches
syn match foundryTraceBranch /[│├└]─/ containedin=ALL
syn match foundryTracePipe   /│/      containedin=ALL
syn match foundryTraceArrow  /←/      containedin=ALL
syn match foundryTraceDblCol /::/     containedin=ALL

" Gas / step counters like: [369560]
syn match foundryTraceGas /\[\d\+\]/

" Call site: ContractOrAlias::function(
syn match foundryTraceContract /\<\h\w*\ze::/
syn match foundryTraceFunction /::\zs\h\w*\ze(/

" Braced struct-like arg names: PoolKey({ ... }), SwapParams({
syn match foundryTraceType /\<\h\w*\ze({/

" Named fields: `name:`, `owner:`, `value:` etc.
syn match foundryTraceField /\<\h\w*:\ze\s/

" Addresses (strict 40-nybble checksummed or lowercased)
syn match foundryTraceAddress /\<0x\x\{40}\>/
" Any hex blob (data / topics / big payloads)
syn match foundryTraceHex /\<0x\x\+\>/

" Numbers incl. bigints and sci notations inside [...]
syn match foundryTraceNumber /\<\d\+\>/
syn match foundryTraceSci /\[\d\.\?\d*[eE][+-]\=\d\+\]/

" Strings
syn region foundryTraceString start=+"+ skip=+\\."+ end=+"+

" Event emission: `emit EventName(`
syn keyword foundryTraceEmit emit
syn match   foundryTraceEvent /\vem it\s\+\zs\h\w*\ze\(/

" Topic lines
syn match foundryTraceTopic /\<topic\s\+\d\+:\>/

" Call modifiers (from Foundry): [staticcall]
syn match foundryTraceModifier /\[\%(staticcall\)\]/

" Return / Stop / Revert blocks
syn match foundryTraceReturn /← \[Return\]\s\zs.*/
syn match foundryTraceStop   /← \[Stop\]/
syn match foundryTraceRevert /← \[Revert\]\s\zs.*/
syn match foundryTraceErrHdr /\<EvmError:\s\zs.*/

" Inline tags like `[Return]`, `[Stop]`, `[Revert]` (when not caught above)
syn match foundryTraceTag /\[\%(Return\|Stop\|Revert\)\]/

" Contract “alias: [0x…]” inline forms (e.g., SellTest: [0x…])
syn match foundryTraceAlias /\<\h\w*:\ze\s*\[0x\x\{40}\]/

" Function-like segments with braces: `receive{value: 123}`
syn match foundryTraceFuncAttr /\<\h\w*\ze{/

" ──────────────────────────────────────────────────────────────────────────────
" Highlight links (use existing colors from your colorscheme)
" ──────────────────────────────────────────────────────────────────────────────

hi def link foundryTraceBranch       Comment
hi def link foundryTracePipe         Comment
hi def link foundryTraceArrow        Operator
hi def link foundryTraceDblCol       Delimiter

hi def link foundryTraceGas          Number
hi def link foundryTraceNumber       Number
hi def link foundryTraceSci          Number

hi def link foundryTraceAddress      Constant
hi def link foundryTraceHex          Constant

hi def link foundryTraceContract     Identifier
hi def link foundryTraceFunction     Function
hi def link foundryTraceType         Type
hi def link foundryTraceFuncAttr     Type

hi def link foundryTraceField        Identifier
hi def link foundryTraceAlias        Identifier

hi def link foundryTraceEmit         Keyword
hi def link foundryTraceEvent        Statement
hi def link foundryTraceTopic        PreProc
hi def link foundryTraceModifier     SpecialComment

hi def link foundryTraceReturn       Special
hi def link foundryTraceStop         Special
hi def link foundryTraceTag          Special
hi def link foundryTraceRevert       Error
hi def link foundryTraceErrHdr       Error

hi def link foundryTraceString       String

let b:current_syntax = "foundry-trace"
