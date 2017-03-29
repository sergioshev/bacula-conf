/**
 * $Id: constraint.sql,v 1.2 2011-11-22 14:13:26 sistemas Exp $
 **
 * Constraints
 */

/* Secuencia de backup_general (id)
 */
ALTER TABLE tq_backup_general
  ALTER COLUMN id
  SET DEFAULT nextval( 'tq_backup_general_id_seq'::regclass ) ;

/* Secuencia de almacen (numero)
 */
ALTER TABLE tq_almacen
  ALTER COLUMN numero
  SET DEFAULT nextval( 'tq_almacen_numero_seq'::regclass ) ;

/* Primary key de tq_almacen
 */
ALTER TABLE ONLY tq_almacen
  ADD CONSTRAINT tq_almacen_pkey
  PRIMARY KEY (numero);

/* Primary key de tq_backup_general
 */
ALTER TABLE ONLY tq_backup_general
  ADD CONSTRAINT tq_backup_general_pkey
  PRIMARY KEY (id);

/* Primary key de tq_volumen_grabado
 */
ALTER TABLE ONLY tq_volumen_grabado
  ADD CONSTRAINT tq_volumen_grabado_pkey
  PRIMARY KEY (volume);

/* Claves foráneas de tq_almacen_backup_general
 */
ALTER TABLE ONLY tq_almacen_backup_general
  ADD CONSTRAINT fkey_almacen_backup_general_almacen
  FOREIGN KEY (almacen)
  REFERENCES tq_almacen(numero)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

ALTER TABLE ONLY tq_almacen_backup_general
  ADD CONSTRAINT fkey_almacen_backup_general_backup_general
  FOREIGN KEY (backup_general)
  REFERENCES tq_backup_general(id)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

/* Claves foráneas de tq_almacen_volumen_grabado
 */
ALTER TABLE ONLY tq_almacen_volumen_grabado
  ADD CONSTRAINT fkey_almacen_volumen_grabado_almacen
  FOREIGN KEY (almacen)
  REFERENCES tq_almacen(numero)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

ALTER TABLE ONLY tq_almacen_volumen_grabado
  ADD CONSTRAINT fkey_almacen_volumen_grabado_volume
  FOREIGN KEY (volume)
  REFERENCES tq_volumen_grabado(volume)
  ON UPDATE CASCADE
  ON DELETE CASCADE;
