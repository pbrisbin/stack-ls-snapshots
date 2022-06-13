PREFIX       ?= /usr/local

.PHONY: install
install:
	install -Dm755 bin/stack-ls-snapshots $(DESTDIR)$(PREFIX)/bin/stack-ls-snapshots

.PHONY: uninstall
uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/stack-ls-snapshots
