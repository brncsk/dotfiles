function status_segment_clock {
	local DEFAULT_FORMAT='%H:%M'

	render_status_segment "$(date +${THEME_CLOCK[format]:-$DEFAULT_FORMAT})"
}
