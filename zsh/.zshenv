# This is so that the homebrew binary is found.
# See https://github.com/Homebrew/homebrew/issues/44997.
export PATH=${PATH}:/usr/local/bin:/usr/local/sbin

command -v brew && { 
  export PATH="${HOME}/.local/bin:/usr/local/bin:${HOME}/.composer/vendor/bin:$(brew --prefix homebrew/php/php70)/bin:${PATH}"
} || {
  export PATH="${HOME}/.local/bin:/usr/local/bin:${HOME}/.composer/vendor/bin:${PATH}"
}
export PYTHONSTARTUP="${HOME}/.pystartup"
export CLICOLOR=1
