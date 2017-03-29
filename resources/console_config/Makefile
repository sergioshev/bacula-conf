# $Id: Makefile,v 1.3 2011-10-25 10:26:08 sistemas Exp $
#
# Makefile para generar la configuración de Bacula.
#

include ../../configs.makefile
include ../../Makefile.base

TARGETS = bconsole.conf
BCONSOLE_DEP = Director-resource.txt

.PHONY: install
install: $(TARGETS)
	install -m 644 $(TARGETS) $(BACULA_BASE_CONF)

.PHONY: cinstall
cinstall: install clean

.PHONY: cfullinstall
cfullinstall: fullinstall clean

# No hace falta recargar el BConsole.
.PHONY: reload
reload:

.PHONY: fullinstall
fullinstall: install

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS)

bconsole.conf: $(BCONSOLE_DEP)
	cat $(BCONSOLE_DEP) > $@
