#!/usr/bin/perl

# $Id: Job-resource.pl,v 1.32 2016/05/23 22:05:09 root Exp $
# ------------------------------------------------------------------------------
#
# Job resource - Director daemon
# ==============================
#

## Definiciones especiales
## -----------------------

print(<<FFAA
# Backup diario estándar para noLan (equipos que no están conectados a la red
# todo el tiempo, generalmente notebooks, pcs, etc).
JobDefs {
  Name = "BackupDiarioNoLan"
  Priority = 10
  Type = Backup
  Level = Differential
  Messages = Standard
  Rerun Failed Levels = Yes
  Max Start Delay = 1 hour
  Allow Duplicate Jobs = No
  Max Full Interval = 5 days
  Max Run Time = 5 hours
  Maximum Concurrent Jobs = 20
  Allow Mixed Priority = Yes
}

# Backup diario estándar (equipos que están conectados a la red todo el
# tiempo).
JobDefs {
  Name = "BackupDiario"
  Priority = 10
  Schedule = "Diario"
  Type = Backup
  Level = Differential
  Messages = Standard
  Rerun Failed Levels = Yes
  Max Start Delay = 1 hour
  Allow Duplicate Jobs = No
  Max Full Interval = 1 week
  Max Run Time = 2 hours
  Maximum Concurrent Jobs = 20
  Allow Mixed Priority = Yes
}

# Restore files.
Job {
  Name = "RestoreFiles"
  Type = Restore
  Client = eloso-fd
  FileSet="eloso-fs"
  Messages = Standard
  Pool = "pool-eloso"
  Storage = File
  Where = "/var/backups/bacula-restores"
  Maximum Concurrent Jobs = 20
}

# Catalogo de Bacula.
Job {
  Name = "db_bacula"
  Client = arsat-fd
  JobDefs = "BackupDiario"
  FileSet = "Catalog"
  Pool = "pool-arsat"
  Client Run After Job  = "/etc/bacula/scripts/delete_catalog_backup"
  Client Run Before Job = "/etc/bacula/scripts/make_catalog_backup"
}

# Backup de eloso
Job {
  Name = "eloso"
  Client = "eloso-fd"
  Client Run Before Job = "/root/bin/make_sql_backup"
  Client Run After Job = "/root/bin/drop_sql_backup"
  FileSet = "eloso-fs"
  JobDefs = "BackupDiario"
  Pool = "pool-eloso"
}

# Backup de zeus
# Está separado en zeus-infogestion y zeus-tq

# zeus-infogestion
Job {
  Name = "zeus-infogestion"
  JobDefs = "BackupDiario"
  Pool = "pool-zeus"
  Client Run Before Job = "c:/backup/make_sql_backup.bat"
  Client Run Before Job = "c:/backup/compactar_bases.bat"
  Client Run After Job = "c:/backup/drop_sql_backup.bat"
  Client = "zeus-fd"
  FileSet = "zeus-infogestion-fs"
}

# zeus-tq
Job {
  Name = "zeus-tq"
  JobDefs = "BackupDiario"
  Pool = "pool-zeus"
  Client = "zeus-fd"
  FileSet = "zeus-tq-fs"
}

# NotUx
Job {
  Name = "notux"
  Type = Backup
  Client = "twister-fd"
  Client Run After Job = "/root/bin/drop_sql_backup"
  Client Run Before Job = "/root/bin/make_sql_backup"
  FileSet = "notux-fs"
  Messages = Quiet
  Pool = "pool-diff-notux"
  Full Backup Pool = "pool-full-notux"
  Schedule = "NotUx"
  Allow Duplicate Jobs = No
}

# Backup de pcsistemas
Job {
  Name = "pcsistemas"
  Client = "pcsistemas-fd"
  FileSet = "pcsistemas-fs"
  JobDefs = "BackupDiario"
  Pool = "pool-diff-pcsistemas"
  Full Backup Pool = "pool-full-pcsistemas"
}

# Backup de pcstock
Job {
  Name = "pcstock"
  Client = "pcstock-fd"
  FileSet = "pcstock-fs"
  JobDefs = "BackupDiarioNoLan"
  Pool = "pool-diff-pcstock"
  Full Backup Pool = "pool-full-pcstock"
  RunScript {
    Command = "C:/WINDOWS/System32/GroupPolicy/User/Scripts/Logoff/matarOutlook.bat"
    Runs On Client = Yes
    Runs When = Before
    Fail Job On Error = No
  }
}

# Backup de twister
Job {
  Name = "twister"
  Client = "twister-fd"
  Client Run Before Job = "/root/bin/make_sql_backup"
  Client Run Before Job = "/root/bin/comprimirLogsLaridae"
  Client Run After Job = "/root/bin/drop_sql_backup"
  Client Run After Job = "/root/bin/archivarLogsLaridae"
  FileSet = "twister-fs"
  JobDefs = "BackupDiario"
  Pool = "pool-twister"
}

# Backup de plcdb
Job {
  Name = "plcdb"
  Client = "plcdb-fd"
  Client Run Before Job = "/root/bin/make_sql_backup"
  FileSet = "plcdb-fs"
  JobDefs = "BackupDiario"
  Pool = "pool-plcdb"
}



# Backup de nebula
Job {
  Name = "nebula"
  Client = "nebula-fd"
  Client Run Before Job = "/usr/local/bin/make_sql_dump"
  FileSet = "nebula-fs"
  JobDefs = "BackupDiario"
  Pool = "pool-nebula"
}

# Backup de pcpersonal (no es volátil)
Job {
  Name = "pcpersonal"
  Client = "pcpersonal-fd"
  FileSet = "pcpersonal-fs"
  JobDefs = "BackupDiarioNoLan"
  Pool = "pool-pcpersonal"
}

FFAA
);

## Definiciones de backups hijos del jobdef BackupDiario
## -----------------------------------------------------

my @InBackupDiarioDef =
  ( "discovery", "panzer", "euro", "ngenio", "phantom", "arsat" );

foreach (@InBackupDiarioDef) {
  print(<<FFAA
Job {
  Name = "$_"
  Client = "$_-fd"
  FileSet = "$_-fs"
  JobDefs = "BackupDiario"
  Pool = "pool-$_"
}

FFAA
  );
}

## Definiciones de backups hijos del jobdef BackupDiarioNoLan
## ----------------------------------------------------------

my @InBackupDiarioNoLanDef = (
  "pcsupmant2", "pcsupmant", "pcdesarrollo", "pcsupadmin", "pccontab",
  "pcntkjefesegu", "pcsecretaria",
  "pcntkjefeadmin", "pcsupseguridad", "pcsupoper", "pcpanol", "pcauxcont",
  "pcimpuesto", "pcsupoper2", "pcdibujante", "pccabezales"
);

foreach (@InBackupDiarioNoLanDef) {
  print(<<FFAA
Job {
  Name = "$_"
  Client = "$_-fd"
  FileSet = "$_-fs"
  JobDefs = "BackupDiarioNoLan"
  Pool = "pool-diff-$_"
  Full Backup Pool = "pool-full-$_"
}

FFAA
  );
}
