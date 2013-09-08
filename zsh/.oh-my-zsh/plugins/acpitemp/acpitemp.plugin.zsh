function acpitemp {
	tempdata=`acpi -t | sed -e 's/\(Thermal 0: \|degrees C\|,\)//g'`
	local tempstat=`echo $tempdata | cut -d' ' -f1`
	local tempval=`echo $tempdata | cut -d' ' -f2`

	if [[ "$tempstat" -eq 'ok' ]]; then
		temprange="ok"
	else
		temprange="critical"
	fi

	echo -n $ZSH_THEME_ACPITEMP[${temprange}_before]
	echo -n $tempval °C
	echo -n $ZSH_THEME_ACPITEMP[${temprange}_after]

} # }}}
