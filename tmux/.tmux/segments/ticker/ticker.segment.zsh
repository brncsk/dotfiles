function status_segment_ticker {
	local DEFAULT_FORMAT='%H:%M'

#	render_status_segment $(curl -s --get http://freegeoip.net.csv/ | cut -f9-10 -d,)
}
