#!/usr/bin/perl

# $Id: Catalog-resource.pl,v 1.2 2013/05/13 19:18:59 aosorio Exp $
# ------------------------------------------------------------------------------
#
# Catalog resource - Director daemon
# ==================================
#

use warnings;
use strict;

print <<FFAA
Catalog {
  Name = MyCatalog
  DB Name = bacula
  DB Address = ""
  DB User = "bacula"
  DB Password = "bacula"
}

FFAA
