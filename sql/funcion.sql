/**
 * $Id: funcion.sql,v 1.7 2013/01/16 09:20:39 aosorio Exp $
 **
 * Funciones
 */

/* Función para registrar el almacenado de backups.
 * TODO: Verificar que existan volúmenes o backups generales para almacenar,
 *       sino se registra un almacenado vacío, lo cual no tiene sentido.
 */
CREATE OR REPLACE FUNCTION registrar_almacen_backup(
  fecha_de_registro timestamp,
  observaciones_de_almacen text,
  OUT almacen integer,
  OUT volumen_bacula integer,
  OUT backup_general integer )
  RETURNS record
  AS $$

    -- Se crea el almacén
    INSERT INTO tq_almacen( fecha_de_almacen, observaciones )
      VALUES ( CURRENT_TIMESTAMP, $2 ) ;

    -- Se asocian los volúmenes de Bacula al nuevo almacén
    INSERT INTO tq_almacen_volumen_grabado( volume )
      SELECT volume
        FROM tq_consulta_volumen_no_almacenado
        WHERE fecha_de_grabado <= COALESCE( $1, CURRENT_TIMESTAMP ) ;

    UPDATE tq_almacen_volumen_grabado
      SET almacen=( SELECT max(numero) FROM tq_almacen )
      WHERE almacen is null ;

    -- Se asocian los backups generales al nuevo almacén
    INSERT INTO tq_almacen_backup_general( backup_general )
      SELECT id
        FROM tq_consulta_backup_general_no_almacenado
        WHERE fecha_de_grabado <= COALESCE( $1, CURRENT_TIMESTAMP ) ;

    UPDATE tq_almacen_backup_general
      SET almacen=( SELECT max(numero) FROM tq_almacen )
      WHERE almacen is null ;

    -- Se retorna un resumen del nuevo almacén
    SELECT almacen,
           count(volume)::integer,
           count(backup_general)::integer
      FROM tq_consulta_detalle_almacen
      GROUP BY almacen
      HAVING almacen=( SELECT max(numero) FROM tq_almacen )

  $$
  LANGUAGE 'sql' ;
