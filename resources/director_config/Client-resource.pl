#!/usr/bin/perl

# $Id: Client-resource.pl,v 1.24 2016/03/10 22:04:57 root Exp $
# ------------------------------------------------------------------------------
#
# Client Resource - Director Daemon
# =================================
#
# Notas
# -----
# 	Se listan los clientes en el hash %clients, donde la clave de cada
#	elemento es el nombre del cliente (sin -fd), y el valor es la
#	contraseña.
#
# Convenciones
# ------------
#	Se asume que el nombre de host es <hash_key>.terminalquequen.com.ar.
#	El nombre de cada cliente será <hash_key>-fd.
#
# Si se desea, se puede especificar una configuración particular de un cliente
# sólo imprimiendola. Por ejemplo:
#
#	print <<FFAA
#	  Client {
#	    Name = clientname-fd
#	    Address = client-addr
#	    ...
#	  }
#	FFAA
#
# Tener en cuenta que en este caso no debe ingresarse el cliente en el hash
# %clients.
# ------------------------------------------------------------------------------
#

use warnings;
use strict;

## Default options
my $catalog = "MyCatalog";
my $max_concurrent_jobs = 10;

my %clients = (
  discovery	=> "9iZ0JdYpjS0pAgE6nQcOQL3MZgyJtbxj6",
  eloso 	=> "Cv70F6pf1t6pBopT4vQOnigDrR0v3L",
  euro 		=> "kYxOmylrm6SGvDU4Z3TPQeB2AhxZoaqrARe9mFnffl1M",
  ngenio 	=> "sdRPsRf4BFjvjPGF8RztgQpM3uPM4BqEcPhLR9AYH1b2d",
  nebula	=> "wcHxvyTRIka6sGQenhYljsuVW7pKXOLj1",
  panzer 	=> "OgLidDCqxpwtvDdU+i2y5+sEN4IVYnoYDUb7ZotrmMV4",
  pcauxcont 	=> "7ry5FMWfBp4WWTw6ZBMh/B+Zb/XiNW2CqYr51LKjr",
  pccontab 	=> "9XiD2d8nLW6UvOPV0zTWw5BBXJPv9/+MCignT9RWXUMh",
  pcdesarrollo 	=> "Eltt070byeBycuP6oVBf8ZUGrPrlasTjjHLi6T9MmBus",
  pcimpuesto 	=> "+KeUoVZtUZUZBeHzB4G1AjZ6fpKPB0x7RqW43HN1VsXw",
  pcntkjefeadmin 	=> "bTDZikFylenYT2NovVqWH9whNlKTHV7SAmX4tJRoetWW",
  pcntkjefesegu => "JWdJ0YU4QnfFPNLa8xMvPo8qfPOByxAzfZkXwabcXczF",
  pcsupseguridad        => "JWdJ0YU4QnfFPNLa8xMvPo8qfPOByxAzfZkXwabcXczF",
  pcntksupadmin => "cwt/Lrb2Yn+RDmU/kUnroKygbbHbHrR9xyScMUX36OwB",
  pcpanol 	=> "Vq5xb7aiXXGrZKVwPzWVnowh0PSU3jkosB1I1OrFPQuh",
  pcpersonal 	=> "G69a33/3sv554PXwvQWz3VMh0woGe9BlfIPsKCUDEynF",
  pcsecretaria 	=> "Rzxp1e6gXrtKeADDhfH5V5nSW3pEhxjFZGfz95A4jEXW",
  pcsistemas 	=> "Cv70F6pf1t6pBopT4vQOnigDrR0v3L",
  pcstock 	=> "x2EDnwrInDgGC6ApE6CJcvRn0Xi139ZnRzc1f/lsO3zL",
  pcsupadmin 	=> "5HfeIf6Megfq91fdIHboGZxOElywYkdK9UyrZJcDqCQk",
  pcsupmant 	=> "opMkxH7TmBehRxuWogHTg8LOIqOD9FnVGpDC7cM0N9JC",
  pcsupmant2 	=> "LWexVtIfdvZNhIw+gwzsFaUrQZPnen7sX9D+WZAO1OhG",
  pcsupoper 	=> "EY4WcND7gTkYN1XTt6Ie+EwGfrsvLhS4LPUXSMGKId6P",
  pcsupoper2 	=> "bSixDIcOrdQd3Iwq6Si3e9UigvBHNXpoZrXp2I6zzDpI",
  phantom 	=> "LgiqQdnmuURi81qo-B68F_8VVNG4BpXx_",
  zeus 		=> "9KUK+21uArgekFSMPLwQ3O3EAheb7ezAJ6+iaR1V5xl3",
  pcdibujante	=> "m307mMDgyFAZ8JUfDgx0QmtDwJ2P1z0ehe+dpxzdfWdi",
  arsat         => "aZmLPopaOVLu77dWtkJsYdH6Cg1SnG_ca",
  pccabezales	=> "53YBSOOEPkhTMD2QzOMdqdjXr-gyejrol",
  twister	=> "5bcWeiRUtok7jINtAnkDqXtrXFDhI6A6D9mVEyydzVLP",
  plcdb 	=> "5bcWeiRUtok7jINtAnkDqajhlAFAalklaxxaertdzfaP"
);

for (keys %clients) {
  print <<FFAA
Client {
  Name = "$_-fd"
  Password = "$clients{$_}"
  Address = $_.terminalquequen.com.ar
  Catalog = $catalog
  Maximum Concurrent Jobs = $max_concurrent_jobs
  File Retention = 30 days
  Auto Prune = Yes
}

FFAA
}
