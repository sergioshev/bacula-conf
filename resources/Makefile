# $Id: Makefile,v 1.5 2015/08/25 13:18:10 root Exp $
#
# Makefile para generar la configuración de Bacula.
#

include ../configs.makefile
include ../Makefile.base

SUBDIRS = console_config director_config \
          storage_daemon_config

CLEANTARGETS=$(patsubst %, _clean_%, $(SUBDIRS))
INSTALLTARGETS=$(patsubst %, _install_%, $(SUBDIRS))
FULLINSTALLTARGETS=$(patsubst %, _fullinstall_%, $(SUBDIRS))
RELOADTARGETS=$(patsubst %, _reload_%, $(SUBDIRS))

.PHONY: all
all:

.PHONY: cinstall
cinstall: install clean

.PHONY: cfullinstall
cfullinstall: fullinstall clean

.PHONY: clean 
clean: $(CLEANTARGETS)

.PHONY: install
install: $(INSTALLTARGETS)

.PHONY: fullinstall
fullinstall: $(FULLINSTALLTARGETS)

.PHONY: reload
reload: $(RELOADTARGETS)

.PHONY: $(RELOADTARGETS)
$(RELOADTARGETS):
	make -C $(patsubst _reload_%, %, $@) reload

.PHONY: $(CLEANTARGETS)
$(CLEANTARGETS):
	make -C $(patsubst _clean_%, %, $@) clean

.PHONY: $(INSTALLTARGETS)
$(INSTALLTARGETS):
	make -C $(patsubst _install_%, % ,$@) install

.PHONY: $(FULLINSTALLTARGETS)
$(FULLINSTALLTARGETS):
	make -C $(patsubst _fullinstall_%, % ,$@) fullinstall
