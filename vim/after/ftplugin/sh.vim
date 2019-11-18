setlocal makeprg=shellcheck\ -fgcc\ -x\ %
setlocal errorformat=%f:%l:%c:\ %trror:\ %m\ [SC%n],%f:%l:%c:\ %tarning:\ %m\ [SC%n],%I%f:%l:%c:\ Note:\ %m\ [SC%n]
