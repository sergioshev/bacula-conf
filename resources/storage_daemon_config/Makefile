# $Id: Makefile,v 1.8 2013/05/17 22:30:55 aosorio Exp $
#
# Makefile para generar la configuración de Bacula.
#

include ../../configs.makefile
include ../../Makefile.base

TARGETS = bacula-sd.conf
BACULA_SD_DEP = Device-resource.txt Director-resource.txt \
  Messages-resource.txt Storage-resource.txt

%.txt : %.pl
	./$? > $@

.PHONY: install
install: $(TARGETS)
	install -m 644 $(TARGETS) $(BACULA_BASE_CONF)

.PHONY: cinstall
cinstall: install clean

.PHONY: cfullinstall
cfullinstall: fullinstall clean

.PHONY: reload
reload:
	$(BACULA_INIT_D_SD) force-reload

.PHONY: restart
restart:
	$(BACULA_INIT_D_SD) restart

.PHONY: fullinstall
fullinstall: install restart

.PHONY: all
all : $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS) Device-resource.txt

bacula-sd.conf: $(BACULA_SD_DEP)
	cat $(BACULA_SD_DEP) > $@
