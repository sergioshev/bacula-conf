# $Id: Makefile,v 1.13 2015/11/14 15:03:45 aosorio Exp $
#
# Makefile de instalación de scripts para Bacula.
#

include ../configs.makefile
include ../Makefile.base

LOCAL = /usr/local/bin
SCRIPTS = corregirBackupConError registrarAlmacenBackup \
  registrarAlmacenBackupToHTML despertarCliente generar_reporte_backups \
  full_volumes_bacula marcar_backup_general_grabado marcar_volumen_grabado \
  volToDVD estadistica_bytes_cliente_fecha runJobConditionally \
  client_is_online addDeferredJob runDeferredJobs

.PHONY: install
install :
	install -m 775 -d $(BACULA_SCRIPTS)
	install -m 755 $(SCRIPTS) $(BACULA_SCRIPTS)
	ln -sf $(BACULA_SCRIPTS)/corregirBackupConError $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/registrarAlmacenBackup $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/registrarAlmacenBackupToHTML $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/despertarCliente $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/generar_reporte_backups $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/full_volumes_bacula $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/marcar_backup_general_grabado $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/marcar_volumen_grabado $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/volToDVD $(LOCAL)
	ln -sf $(BACULA_SCRIPTS)/estadistica_bytes_cliente_fecha $(LOCAL)

.PHONY : fullinstall
fullinstall : install runDeferredJobs.crontab
	install -m 664 runDeferredJobs.crontab /etc/cron.d
