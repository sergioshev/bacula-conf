#!/usr/bin/perl

# $Id: Director-resource.pl,v 1.2 2013/05/13 19:18:59 aosorio Exp $
# ------------------------------------------------------------------------------
#
# Director resource - Director daemon
# ===================================
#

use warnings;
use strict;

print <<FFAA
Director {
  Name = bacula-dir
  Query File = "/etc/bacula/scripts/query.sql"
  Working Directory = "/var/lib/bacula"
  Pid Directory = "/var/run/bacula"
  Maximum Concurrent Jobs = 50
  Password = "Cv70F6pf1t6pBopT4vQOnigDrR0v3L"
  Messages = Daemon
}

FFAA
