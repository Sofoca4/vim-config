function s:DbConnectionGetLine()
	let l:lineN = line('.')
	if foldlevel(l:lineN) < 1
		return -1
	endif
	if foldlevel(l:lineN) > 1
		while l:lineN > 0
			let l:lineN = l:lineN - 1
			if foldlevel(l:lineN) <= 1
				break
			endif
		endwhile
	endif
	return l:lineN
endfunction

function DbConnectionSetup()
	nnoremap <buffer> <Enter> :call DbConnectionTryConnect()<CR>
endfunction

function DbConnectionTryConnect()
	let l:connectionLine = s:DbConnectionGetLine()

	exec ':normal! ' . l:connectionLine . 'Gma'

	if exists('s:dbConnectionIndexSelected') && l:connectionLine == s:dbConnectionIndexSelected
		echo 'Already connected!'
		return
	endif

	:match none
	let s:dbConnectionIndexSelected = -1

	if l:connectionLine == -1
		echo 'No valid connection found!'
		exec 'match Operator /^.*\%''a.*$/'
		return
	endif


	let s:dbConnectionCredentials = s:DbConnectionGetData(l:connectionLine)

	if s:dbConnectionCredentials.isValid == 'y'
		let s:dbConnectionCredentials.passwordValue = inputsecret("Enter your password: ")
		:redraw

		if s:DbConnectionTestConnection(s:dbConnectionCredentials) == 'y'
			let s:dbConnectionIndexSelected = l:connectionLine
			exec 'match Type /^.*\%''a.*$/'
			:echo 'Connection stablished!'
			return
		endif
	endif

	exec 'match Operator /^.*\%''a.*$/'
	echo 'The connection is not valid'
endfunction

function s:DbConnectionTestConnection(connection)
	let l:template = 'sqlcmd -S %s -d %s -U %s -P %s -Q "print ''Test''"'
	let l:template = printf(l:template,a:connection.serverValue,a:connection.dbValue, a:connection.userValue,a:connection.passwordValue)

	let l:result = trim(system(l:template))

	if l:result == 'Test'
		return 'y'
	endif

	return 'n'
endfunction

function s:DbConnectionGetData(lineNumber)
	let l:Result = {'serverValue':'','dbValue':'','userValue':'', 'isValid':'n', 'passwordValue':''}

	let l:serverIndex = a:lineNumber+1
	let l:dbIndex = a:lineNumber+2
	let l:userIndex = a:lineNumber+3

	if foldlevel(l:serverIndex) == 2 && foldlevel(l:dbIndex) == 2 && foldlevel(l:userIndex) == 2
		let l:Result.serverValue = trim(getline(l:serverIndex))
		let l:Result.dbValue = trim(getline(l:dbIndex))
		let l:Result.userValue = trim(getline(l:userIndex))

		if len(l:Result.serverValue) > 0 && len(l:Result.dbValue) > 0 && len(l:Result.userValue) > 0
			let l:Result.isValid = 'y'
		endif
	endif

	return l:Result
endfunction

" Execute query thing
let s:sql_scratch = "personal-sql-scratch"
let s:sql_scratch_tmp_file = "/tmp/vim-sql-plugin-tmp-input.sql"

function g:DbConnectionExecuteCurrentQuery()
	if !exists('s:dbConnectionCredentials') || s:dbConnectionCredentials.isValid != 'y'
		echo "There is no active connections."
		return
    endif
	
	let l:currentWindow = winnr()

	exec ':w! ' . s:sql_scratch_tmp_file

    if bufwinnr(s:sql_scratch) > -1
        exec ':bd ' . s:sql_scratch
    endif


    " let l:bcontent = join(getline(1,'$'))
    " let l:bcontent = substitute(l:bcontent,'%','\\%','g')
    " let l:bcontent = substitute(l:bcontent,'#','\\#','g')
    " let l:bcontent = substitute(l:bcontent,'!','\\!','g')

    exec ':below split ' . s:sql_scratch
    :setlocal buftype=nofile
    :setlocal bufhidden=delete
    :setlocal noswapfile


    ":setlocal nobuflisted
    " exec ':r!echo new ' . l:current.server . ' - ' . l:current.user . ' - ' . l:current.password
    " let l:filename = expand('%:p')
    " exec ':r!echo ' . l:filename
	" let l:command_pattern = 'sqlcmd -S %s -d %s -U %s -P %s -Q "%s"'
	let l:template = 'sqlcmd -S %s -d %s -U %s -P %s -i %s'
	let l:template = printf(l:template,s:dbConnectionCredentials.serverValue,s:dbConnectionCredentials.dbValue, s:dbConnectionCredentials.userValue,s:dbConnectionCredentials.passwordValue,s:sql_scratch_tmp_file)
    exec 'r!' . l:template
    normal! gg
	exe l:currentWindow . 'wincmd w'
endfunction

function DbConnectionGetPrettyName()
	if exists('s:dbConnectionCredentials') && s:dbConnectionCredentials.isValid == 'y'
		let l:prettySvName = 'localhost'

		if s:dbConnectionCredentials.serverValue != '.'
			let l:prettySvName = s:dbConnectionCredentials
		endif

		return printf('%s@%s',l:prettySvName, s:dbConnectionCredentials.userValue)
	endif

	return ''
endfunction
