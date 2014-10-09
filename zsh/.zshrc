# Basic stuff
export NAME="Ádám Barancsuk"
export EMAIL="adam.barancsuk@gmail.com"

export EDITOR=vim
export VISUAL=gedit
export BROWSER=firefox

LIB_DIR=.zsh/lib
PLUGIN_DIR=.zsh/plugins
ENABLED_PLUGINS=(archlinux git loadavg zsh-syntax-highlighting find custom-prompt)

# Libraries
for lib in ${LIB_DIR}/*.lib.zsh; do
	source $lib
done

# Then compinit
autoload -U compinit
compinit -i

# Then plugins
for plugin in $ENABLED_PLUGINS; do
	[ -r ${PLUGIN_DIR}/${plugin}/${plugin}.plugin.zsh ] && \
		source ${PLUGIN_DIR}/${plugin}/${plugin}.plugin.zsh
done
