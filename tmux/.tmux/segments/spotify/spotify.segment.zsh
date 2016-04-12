function status_segment_spotify {
  if [ $(osascript -e 'application "Spotify" is running') = "false" ]; then
    return
  fi

  artist=$(osascript -e 'tell application "Spotify" to artist of current track as string');
  album=$(osascript -e 'tell application "Spotify" to album of current track as string');
  track=$(osascript -e 'tell application "Spotify" to name of current track as string');
  state=$(osascript -e 'tell application "Spotify" to player state as string');

  if [[ state = "playing\n" ]]; then
    char=$CH[aR]
  else
    char='‖'
  fi

	render_status_segment_split "34" "$char" "${artist} – ${track}"
}

