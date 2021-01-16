function! Jid(dic)
  call s:_jid_core(a:dic, 0)
endfunction
function! Jid_popup(dic)
  call s:_jid_core(a:dic, 1)
endfunction

" ---
function! s:_jid_core(dic, popup)
  let l:temp = tempname()
  execute ":redir! > " . l:temp
    silent! echon s:_json_encode_irreversible(0, a:dic)
  redir END

  " NOTE: popup化(する時はterm_startでhidden: 1)
  let l:id = term_start([&shell], #{ hidden: a:popup ? 1 : 0, term_finish: 'close' })
  call term_sendkeys(l:id, "cat ".l:temp." | jid -M\<CR>")
  if a:popup
    call popup_create(l:id, #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 })
endif
endfunction

" original) https://github.com/mattn/webapi-vim/blob/master/autoload/webapi/json.vim :webapi#json#encode()
function! s:_json_encode_irreversible(depth, val) abort
  if type(a:val) == 0
    return a:val
  elseif type(a:val) == 1 
    let json = '"' . escape(a:val, '\"') . '"'
    let json = substitute(json, "\r", '\\r', 'g')
    let json = substitute(json, "\n", '\\n', 'g')
    let json = substitute(json, "\t", '\\t', 'g')
    "let json = substitute(json, '\([[:cntrl:]]\)', '\=printf("\x%02d", char2nr(submatch(1)))', 'g')
    return iconv(json, &encoding, "utf-8")

    "return json_encode(a:val)
  elseif type(a:val) == 2
    return '"' . s:string_fn(a:val) . '"'
  elseif type(a:val) == 3
    if a:depth > 7 | return '["%%MAX_DEPTH%%:' . a:depth . '"]' | endif
    return '[' . join(map(copy(a:val), 's:_json_encode_irreversible(a:depth+1, v:val)'), ',') . ']'
  elseif type(a:val) == 4
    " NOTE: 深すぎるとmaxfuncdepthを超えるエラーが出る
    if a:depth > 7 | return '{"%%MAX_DEPTH%%":' . a:depth . '}' | endif
    return '{' . join(map(keys(a:val), 's:_json_encode_irreversible(a:depth+1, v:val).":".s:_json_encode_irreversible(a:depth+1, a:val[v:val])'), ',') . '}'
  elseif type(a:val) == 5
    return a:val
  elseif type(a:val) == 6
    if a:val == v:true
      return 'true'
    elseif a:val == v:false
      return 'false'
    endif
    throw 'unknown type 5 value:'.string(a:val)
  elseif type(a:val) == 7
    if a:val == v:null
      return 'null'
    elseif a:val == v:none
      return '"v:none"'
    endif
    throw 'unknown type 7 value:'.string(a:val)
  elseif type(a:val) == 8
    return '"' . "job('" . string(a:val) . "')" . '"'
  elseif type(a:val) == 9
    return '"' . "ch('" . string(a:val) . "')" . '"'
  elseif type(a:val) == 10
    return '"' . "blob('" . string(a:val). "')" . '"'
  else
    throw 'unknown type:'.type(a:val)
  endif
endfunction

function! s:string_fn(fn)
  let l:sfn = string(a:fn)
  let l:start = stridx(l:sfn, "'")
  let l:end = l:start+1 + stridx(l:sfn[l:start+1:], "'")

  if l:sfn[l:end:] == "')"
    return l:sfn
  else
    " NOTE: 長いと見辛いので省略
    return l:sfn[:l:end] . ', ...)'
  endif
endfunction
