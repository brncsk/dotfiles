MODULES_BASE=bash git terminfo tmux vim zsh misc
MODULES_BIN=bin
MODULES_X=qgis x

PREFIX:=~
PREFIX_BIN=~/.local

LN_FLAGS=-sfn

export

.PHONY: $(MODULES_BASE) $(MODULES_BIN) $(MODULES_X)

install: create-dest-dirs install-base install-bin install-x
install-non-x: create-dest-dirs install-base install-bin

install-base: $(MODULES_BASE)
install-bin: $(MODULES_BIN)
install-x: $(MODULES_X)

create-dest-dirs:
	mkdir -p $(PREFIX) $(PREFIX_BIN)/bin

$(MODULES_BASE) $(MODULES_BIN) $(MODULES_X):
	for f in $@/* $@/.*; do \
		$$(echo $$f | grep -qvE "[\.*]\.?$$") \
			&& ln $(LN_FLAGS) $$(pwd)/$$f \
				$(if $(findstring $@,$(MODULES_BIN)),$(PREFIX_BIN)/bin,$(PREFIX))/$$(basename $$f) \
			|| true; \
	done
	export PREFIX
	cd $@; [ -e Makefile ] && $(MAKE) || true
