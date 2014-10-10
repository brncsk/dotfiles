(if [[ $(i8kfan) == "0 0" ]]; then
	i8kfan 2 2
else
	i8kfan 0 0
fi) > /dev/null
