ff () {
	(find ${2:=.} -print0 | xargs -0 grep $1 ) 2>/dev/null
}
