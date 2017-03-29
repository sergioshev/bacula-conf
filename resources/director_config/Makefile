# $Id: Makefile,v 1.15 2016/03/10 23:04:13 root Exp $
#
# Makefile para generar la configuración de Bacula.
#

include ../../configs.makefile
include ../../Makefile.base

TARGETS = bacula-dir.conf Client-resource.txt Catalog-resource.txt \
  Console-resource.txt Director-resource.txt Pool-resource.txt \
  Storage-resource.txt Job-resource.txt

DEPENDENCES = Messages-resource.txt Schedule-resource.txt Job-resource.txt \
  Client-resource.txt Catalog-resource.txt Console-resource.txt \
  Director-resource.txt Pool-resource.txt Storage-resource.txt \
  FileSet-resource.txt

.PHONY: install
install: $(TARGETS) bacula_schedule-no-lan
	install -m 644 bacula-dir.conf $(BACULA_BASE_CONF)
	install -m 644 bacula_schedule-no-lan /etc/cron.d

.PHONY: cinstall
cinstall: install clean

.PHONY: cfullinstall
cfullinstall: fullinstall clean

.PHONY: reload
reload:
	$(BACULA_INIT_D_DIRECTOR) reload

.PHONY: restart
restart:
	$(BACULA_INIT_D_DIRECTOR) restart

.PHONY: fullinstall
fullinstall: install restart

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS) bacula_schedule-no-lan

bacula_schedule-no-lan:  Schedule-NoLan.txt
	../../scripts/makeCrontabNoLan < $? > $@

%.txt : %.pl
	./$? > $@

bacula-dir.conf : $(DEPENDENCES)
	cat $(DEPENDENCES) > $@
