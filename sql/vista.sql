/**
 * $Id: vista.sql,v 1.17 2015/11/09 13:17:40 aosorio Exp $
 **
 * Vistas
 */

/* Detalle de almacén
 */
CREATE OR REPLACE VIEW tq_consulta_detalle_almacen AS
--{{{
  SELECT a.numero AS almacen,
         a.fecha_de_almacen,
         vg.volume AS volume,
         NULL AS backup_general,
         NULL AS medio
    FROM tq_almacen_volumen_grabado avg
    JOIN tq_volumen_grabado vg
      ON avg.volume=vg.volume
    JOIN tq_almacen a
      ON avg.almacen=a.numero
    UNION SELECT a.numero AS almacen,
                 a.fecha_de_almacen,
                 NULL AS volume,
                 periodo_contenido_inicio || ' - ' ||
                 periodo_contenido_fin || ' - ' ||
                 descripcion_contenido AS backup_general,
                 bg.medio
      FROM tq_almacen_backup_general abg
      JOIN tq_backup_general bg
        ON abg.backup_general=bg.id
      JOIN tq_almacen a
        ON abg.almacen=a.numero
      ORDER BY fecha_de_almacen,
               volume,
               backup_general ;
--}}}

/* Lista de volúmenes de Bacula no almacenados
 */
CREATE OR REPLACE VIEW tq_consulta_volumen_no_almacenado AS
--{{{
  SELECT volume,
         fecha_de_grabado
    FROM tq_volumen_grabado
    WHERE volume NOT IN ( SELECT volume
                            FROM tq_almacen_volumen_grabado ) ;
--}}}

/* Lista de backup general no almacenado
 */
CREATE OR REPLACE VIEW tq_consulta_backup_general_no_almacenado AS
--{{{
  SELECT id,
         fecha_de_grabado
    FROM tq_backup_general
    WHERE id NOT IN ( SELECT backup_general
                        FROM tq_almacen_backup_general ) ;
--}}}

/* Resumen de almacén
 */
CREATE OR REPLACE VIEW tq_consulta_resumen_almacen AS
--{{{
  SELECT almacen,
         fecha_de_almacen,
         count(volume) AS volumen_bacula,
         count(backup_general) AS backup_general
    FROM tq_consulta_detalle_almacen
    GROUP BY almacen,
             fecha_de_almacen
    ORDER BY fecha_de_almacen ;
--}}}

/* Lista de volúmenes para grabar.
 */
CREATE OR REPLACE VIEW tq_consulta_volumen_no_grabado AS
--{{{
  SELECT m.volumename as name,
         m.volstatus as status,
         m.lastwritten as lastwritten,
         m.volbytes as size_bigint,
         pg_size_pretty(m.volbytes::bigint) as size,
         m.voljobs as jobs,
         s.name as storage,
         p.name as pool
    FROM media m
    JOIN storage s
      USING (storageid)
    JOIN pool p
      USING (poolid)
    WHERE volstatus not in ('Archive', 'Append', 'Error', 'Purged') AND
          -- Con esto se descartan los pools volátiles (pool-diff-... y
          -- pool-full-...).
          p.name !~ '^pool-[diff|full]'
    ORDER BY lastwritten;
--}}}

/* Vista de último backup terminado en error por cada cliente.
 */
CREATE OR REPLACE VIEW tq_backup_con_error AS
--{{{
  SELECT j.*,
         c.name AS clientname
    FROM job j
    JOIN client c
      ON c.clientid=j.clientid
    WHERE j.jobid IN ( SELECT max( u.jobid )
                       FROM job u
                       GROUP BY u.clientid ) AND
          j.jobstatus<>'T' AND
          j.type='B' AND
          j.endtime IS NOT NULL ;
--}}}

/* Tamaño de backups por cliente por dia.
 */
CREATE OR REPLACE VIEW tq_bytes_por_cliente_dia AS
--{{{
  SELECT clientid,
         starttime::date,
         sum(jobbytes) as bytes_por_dia
    FROM job
    GROUP BY clientid,
             starttime::date,
             jobstatus
          HAVING jobstatus='T'
    ORDER BY starttime::date;
--}}}
