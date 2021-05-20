PREFIX = /usr/local

install:
	cp cdup.sh $(PREFIX)/bin/cdup

uninstall:
	rm -f $(PREFIX)/bin/cdup
