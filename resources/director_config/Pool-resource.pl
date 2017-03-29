#!/usr/bin/perl

# $Id: Pool-resource.pl,v 1.16 2016/01/25 15:53:14 root Exp $
# ------------------------------------------------------------------------------
#
# Pool resource - Director daemon
# ===============================
#

package scriptsConfig;
do "../scriptsConfig.conf";

my @pools = ( "discovery", "eloso", "euro", "ngenio", "nebula", "panzer",
  "phantom", "zeus", "arsat", "twister", "pcpersonal", "plcdb" );

foreach my $pool (@pools) {
  print <<FFAA
Pool {
  Name = pool-$pool
  Label Format = "$pool\_\${Year}-\${Month:p/2/0/r}-\${Day:p/2/0/r}_\${NumVols:p/4/0/r}"
  File Retention = 30 days
  Auto Prune = Yes
  Pool Type = Backup
  Volume Retention = 10 years
  Recycle = No
  Volume Use Duration = 1 week
  Maximum Volume Bytes = 4G
  Storage = $pool-storage
}

FFAA
}

foreach my $pool (@scriptsConfig::jobs_volatiles) {
  print <<FFAA
Pool {
  Name = pool-full-$pool
  Pool Type = Backup
  Catalog Files = No
  Label Format = "$pool-full-"
  Volume Use Duration = 1 day
  Storage = $pool-storage
  Maximum Volumes = 2
  Recycle = Yes
  Volume Retention = 1 day
}

Pool {
  Name = pool-diff-$pool
  Pool Type = Backup
  Catalog Files = No
  Label Format = "$pool-diff-"
  Volume Use Duration = 1 day
  Storage = $pool-storage
  Maximum Volumes = 5
  Recycle = Yes
  Volume Retention = 1 day
}

FFAA
}
