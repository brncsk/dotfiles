ff () {
	(find ${2:=.} -print0 | xargs -0 grep -i $1 ) 2>/dev/null
}
