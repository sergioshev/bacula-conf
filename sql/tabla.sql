/**
 * $Id: tabla.sql,v 1.1 2011-11-22 10:25:33 sistemas Exp $
 **
 * Tablas
 */

/* Almacen para volumenes de Bacula
 */
CREATE TABLE tq_almacen (
    numero integer NOT NULL,
    fecha_de_almacen timestamp without time zone,
    observaciones text
) ;

/* Almacen para backup en general
 */
CREATE TABLE tq_almacen_backup_general (
    almacen integer,
    backup_general integer
) ;

/* Tabla de relacion n->n tq_almacen->tq_volumen_grabado
 */
CREATE TABLE tq_almacen_volumen_grabado (
    almacen integer,
    volume text
) ;

/* Backup general
 */
CREATE TABLE tq_backup_general (
    fecha_de_grabado timestamp without time zone DEFAULT now(),
    id integer NOT NULL,
    medio text,
    periodo_contenido_inicio date,
    periodo_contenido_fin date,
    descripcion_contenido text
) ;

/* Volumen de Bacula
 */
CREATE TABLE tq_volumen_grabado (
    volume text NOT NULL,
    fecha_de_grabado timestamp without time zone
) ;
