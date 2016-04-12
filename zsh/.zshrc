# Basic stuff
export NAME="Ádám Barancsuk"
export EMAIL="adam barancsuk gmail com"

export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox

LIB_DIR=~/.zsh/lib
PLUGIN_DIR=~/.zsh/plugins
ENABLED_PLUGINS=(archlinux zsh-syntax-highlighting custom-prompt)

source /etc/profile
source ~/.zshenv

# Initialize autocompletion
autoload -U compinit
compinit -i

# Libraries
for lib in ${LIB_DIR}/*.lib.zsh; do
	source $lib
done

# Then plugins
for plugin in "${ENABLED_PLUGINS[@]}"; do
	[ -r ${PLUGIN_DIR}/${plugin}/${plugin}.plugin.zsh ] && \
		source ${PLUGIN_DIR}/${plugin}/${plugin}.plugin.zsh
done

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
