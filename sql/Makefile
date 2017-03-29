# $Id: Makefile,v 1.4 2013/01/11 12:16:38 aosorio Exp $
#
# Makefile de base de datos
#

.PHONY: all
all:

.PHONY: regenerarvistas
regenerarvistas: vista.sql
	cat vista.sql | psql -U bacula

.PHONY: regenerartablas
regenerartablas: tabla.sql secuencia.sql constraint.sql
	cat tabla.sql secuencia.sql constraint.sql | psql -U bacula

.PHONY: regenerarfunciones
regenerarfunciones: funcion.sql
	cat funcion.sql | psql -U bacula

.PHONY: export
export:
	pg_dump -U bacula bacula > bacula.sql

.PHONY: rebuild
rebuild: destroydb createdb import

.PHONY: destroydb
destroydb:
	su postgres -c 'dropdb bacula'

.PHONY: createdb
createdb:
	su postgres -c 'createdb -E SQL_ASCII bacula -O bacula -T template0'
	su postgres -c 'createlang plpgsql bacula'

.PHONY: import
import:
	cat bacula.sql | \
	psql bacula -U bacula 2>&1 | tee .import
	@if grep ERROR .import ; then \
	  rm -f .import ; exit 1 ; \
	else rm -f .import ; fi
