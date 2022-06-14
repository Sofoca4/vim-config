:nnoremap <buffer> <F5> :call DbConnectionExecuteCurrentQueryWrp()<CR>
:inoremap <buffer> <F5> <Esc>:call DbConnectionExecuteCurrentQueryWrp()<CR>

setlocal statusline=
setlocal statusline+=\ %f
setlocal statusline+=\%= " separator
setlocal statusline+=%#StatusLineTerm#
setlocal statusline+=%20{DbConnectionGetPrettyNameWrp(20)}%*
" setlocal statusline+=%#StatusLine#
setlocal statusline+=\ %l\-%v
setlocal statusline+=\ %p


function DbConnectionExecuteCurrentQueryWrp()
	if exists('*DbConnectionExecuteCurrentQuery')
		:call DbConnectionExecuteCurrentQuery()
		return
	endif

	echo 'There is no active connection!'
endfunction

function DbConnectionGetPrettyNameWrp(minLength)
	if exists('*DbConnectionGetPrettyName')
		let l:result = DbConnectionGetPrettyName()
		if len(l:result) > 0
			let l:targetLenght = a:minLength - len(l:result)
			let l:result = l:result . repeat(' ',l:targetLenght/2)
		return l:result
	endif
	return ''
endfunction
