/**
 * $Id: secuencia.sql,v 1.2 2011-11-22 14:13:26 sistemas Exp $
 **
 * Secuencias
 */

/* Secuencia para identificar el backup general
 */
CREATE SEQUENCE tq_backup_general_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1 ;

/* Secuencia para identificar el almacén
 */
CREATE SEQUENCE tq_almacen_numero_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1 ;
