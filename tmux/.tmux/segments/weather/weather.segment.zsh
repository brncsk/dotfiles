function status_segment_weather {
	local GEOIP_BACKEND=http://www.telize.com/geoip
	local GEOINFO_FILE=~/.tmux/segments/weather/.geoip.tmp
	local WEATHER_BACKEND="http://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&units=metric"
	local FORECAST_BACKEND="http://api.openweathermap.org/data/2.5/forecast/daily?lat={lat}&lon={lon}&units=metric&mode=json&cnt=2"
	local WEATHER_FILE=~/.tmux/segments/weather/.weather.tmp
	local FORECAST_FILE=~/.tmux/segments/weather/.forecast.tmp
	
	local UPDATE_INTERVAL=120
	local WIND_HIGH_THRESHOLD=20
	local FORECAST_TOMORROW_THRESHOLD=12

	typeset -A weather_icons
	weather_icons=(
		01d 	01n	
		02d 	02n	
		03d 	03n 	
		04d		04n 
		09d 	09n	
		10d		10n	
		11d 	11n 
		13d		13n	
		50d		50n	
	)

	typeset -A weather_wind_arrows
	weather_wind_arrows=(

		S_l	↑	SE_l	↖
		E_l	←	NE_l	↙
		N_l	↓	NW_l	↘
		W_l	←	SW_l	↗

		S_h	⬆	SE_h	⬉
		E_h	⬅	NE_h	⬋
		N_h	⬇	NW_h	⬊
		W_h	⬅	SW_h	⬈
	)

	typeset -A weather_colors
	weather_colors=(
		01d	226	01n 27
		02d	226	02n 39
		03d 158	03n 75
		04d 67	04n 67
		10d 67	10n 67
	)

	# Refresh if file does not exist or is older than $UPDATE_INTERVAL
	([ ! -f ${WEATHER_FILE} ] || \
		[ $(($(date +%s) - $(stat -c%Y ${WEATHER_FILE}))) -gt ${UPDATE_INTERVAL} ] \
	) && {
		curl -s --get ${GEOIP_BACKEND} > ${GEOINFO_FILE}
		latlon=($(jshon -e latitude -upe longitude <${GEOINFO_FILE} | paste -s -d' '))

		weather_uri=$(echo ${WEATHER_BACKEND} | sed -e "s/{lat}/${latlon[1]}/" | sed -e "s/{lon}/${latlon[2]}/")
		forecast_uri=$(echo ${FORECAST_BACKEND} | sed -e "s/{lat}/${latlon[1]}/" | sed -e "s/{lon}/${latlon[2]}/")

		(curl -s --get ${weather_uri} ) > ${WEATHER_FILE}
		(curl -s --get ${forecast_uri} ) > ${FORECAST_FILE}
	}

	weather_info=$(jshon -eweather -e0 -emain -u <${WEATHER_FILE})
	weather_temp=$(printf '%d' $(jshon -emain -etemp -u <${WEATHER_FILE}))
	weather_location=$(jshon -ecity -u <${GEOINFO_FILE})
	weather_icon_id=$(jshon -eweather -e0 -eicon -u <${WEATHER_FILE})
	weather_icon=${weather_icons[${weather_icon_id}]}
	weather_color=$weather_colors[$weather_icon_id]
	weather_wind_direction=$(jshon -ewind -edeg -u <${WEATHER_FILE})
	weather_wind_speed=$(printf '%d' $(jshon -ewind -espeed -u <${WEATHER_FILE}))
	[[ ${weather_wind_speed} -gt 20 ]] && weather_wind_speed_class=h || weather_wind_speed_class=l
	weather_wind_arrow=${weather_wind_arrows[$(_wind_direction ${weather_wind_direction})_${weather_wind_speed_class}]}
	
	[[ $(date +%k) -ge ${FORECAST_TOMORROW_THRESHOLD} ]] && {
		forecast_index=1; forecast_designation="tm: " } || {
		forecast_index=0; forecast_designation="" }
	forecast_desc=${$(jshon -elist -e${forecast_index} -eweather -e0 -emain -u <${FORECAST_FILE}):l}
	forecast_max=$(printf "%d" $(jshon -elist -e${forecast_index} -etemp -emax -u <${FORECAST_FILE}))

	render_status_segment_split \
		"${weather_color}" \
		"${weather_icon}  ${weather_wind_arrow} (${weather_wind_speed} kph)"  \
		"$FX[b+]$FG[232]${weather_temp} °C$FX[b-] $FG[233]$FX[i+](${forecast_designation}${forecast_desc}, ${forecast_max} °C)$FX[i-]"
}

function _wind_direction () {
	[[  22 -lt $1 && $1 -lt  67 ]] &&  { echo "NE"; return; }
	[[  68 -lt $1 && $1 -lt 112 ]] &&  { echo "E";  return; }
	[[ 113 -lt $1 && $1 -lt 157 ]] &&  { echo "SE"; return; }
	[[ 157 -lt $1 && $1 -lt 202 ]] &&  { echo "S";  return; }
	[[ 203 -lt $1 && $1 -lt 247 ]] &&  { echo "SW"; return; }
	[[ 248 -lt $1 && $1 -lt 292 ]] &&  { echo "W";  return; }
	[[ 293 -lt $1 && $1 -lt 337 ]] &&  { echo "NW"; return; }
	echo "N";
}
