#!/usr/bin/perl

# $Id: Device-resource.pl,v 1.11 2015/02/02 21:43:29 aosorio Exp $
# ------------------------------------------------------------------------------
#
# Device resource - Storage daemon
# ================================
#

package scriptsConfig;
do "../scriptsConfig.conf";

my $arch_device = "/var/backups/bacula";

## Devices con configuración particular
print( <<FFAA
Device {
  Name = FileStorage
  Archive Device = $arch_device
  Always Open = Yes
  Random Access = Yes
  Label Media = yes
  Maximum Concurrent Jobs = 50
  Media Type = File
  Random Access = Yes
}

FFAA
);

foreach (@scriptsConfig::jobs_volatiles, @scriptsConfig::jobs_no_volatiles) {
  print <<FFAA
Device {
  Name = $_-dev
  Archive Device = "$arch_device/$_"
  Always Open = Yes
  Random Access = Yes
  Label Media = Yes
  Media Type = $_-media
  Random Access = Yes
  Maximum Concurrent Jobs = 50
}

FFAA
}
