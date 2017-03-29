#!/usr/bin/perl

# $Id: Storage-resource.pl,v 1.8 2015/05/22 22:28:48 root Exp $
# ------------------------------------------------------------------------------
#
# Storage resource - Director daemon
# ==================================
#

package scriptsConfig;
do "../scriptsConfig.conf";

print( <<FFAA
Storage {
  Name = File
  Address = bacula-sd.terminalquequen.com.ar
  Password = "$scriptsConfig::bacula_sd_passwd"
  Device = FileStorage
  Media Type = File
  Maximum Concurrent Jobs = 50
}

FFAA
);

foreach (@scriptsConfig::jobs_volatiles, @scriptsConfig::jobs_no_volatiles) {
  print <<FFAA
Storage {
  Name = $_-storage
  Address = bacula-sd.terminalquequen.com.ar
  Password = "$scriptsConfig::bacula_sd_passwd"
  Device = $_-dev
  Maximum Concurrent Jobs = 50
  Media Type = "$_-media"
}

FFAA
}
