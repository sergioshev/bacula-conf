#!/usr/bin/perl

# $Id: Console-resource.pl,v 1.2 2013/05/13 19:18:59 aosorio Exp $
# ------------------------------------------------------------------------------
#
# Console resource - Director daemon
# ==================================
#

use warnings;
use strict;

print <<FFAA
Console {
  Name = user-console
  Password = "1TrDLpBOmII8bkyAV9S6c6vh1w7FkEz14jaq69QMyBGQz"
  Command ACL = run, wait, q
  Catalog ACL = MyCatalog
  Pool ACL = *all*
  Job ACL = *all*
  Storage ACL = *all*
  Client ACL = *all*
  FileSet ACL = *all*
}

FFAA
