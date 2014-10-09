#! /bin/zsh
# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Copied from http://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

typeset -Ag FX FG BG _FG _BG

FX=(
	0  "%{[00m%}"
	b+ "%{[01m%}" b- "%{[22m%}"
	i+ "%{[03m%}" i- "%{[23m%}"
	u+ "%{[04m%}" u- "%{[24m%}"
	l+ "%{[05m%}" l- "%{[25m%}"
	r+ "%{[07m%}" r- "%{[27m%}"
)

for color in {000..255}; do
    _FG[$color]="[38;5;${color}m"
	FG[$color]="%{"$_FG[$color]"%}"
    _BG[$color]="[48;5;${color}m"
	BG[$color]="%{"$_BG[$color]"%}"
done

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

