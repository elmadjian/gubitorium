#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: programa.pl
#
#        USAGE: ./programa.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 09/13/2013 12:21:47
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

use montador;
use vm;

print ">>Chamando montador...\n";
my @programa = &montador;
print ">>Montador terminado.\n";

# print "Imprimindo saida do montador (vetor):\n";
# for (my $i = 0; $i <= $#programa; $i++) {
# 	print "$programa[$i][0] $programa[$i][1]\n";
# }

print ">>Chamando maquina virtual...\n";
vm(@programa);
print ">>Maquina virtual terminada\n";
