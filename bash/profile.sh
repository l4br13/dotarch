# startx
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	if [ -f ~/.Xauthority ]: then
		rm -rf ~/.Xauthority
	fi
	exec startx
fi
