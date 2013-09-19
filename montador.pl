#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: montador.pl
#
#        USAGE: ./montador.pl  
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
#      CREATED: 09/06/2013 13:43:42
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

my $counter = 0;
my @programa;
my %hash;

while (<>) {
	$_ =~ s/[#].*//;
	if ($_ =~ /\w/) {
		$_ =~ /\s*(.*\:)?\s*?([A-Z]{2,4})\s*([-]?\w*)/;
		my $regex1 = $1;
		my $regex2 = $2;
		my $regex3 = $3;

		if ($regex1) {
			$regex1 =~ s/\s*[:].*//;
			$hash{$regex1} = $counter;
		}
		if ($regex2 =~ /(JMP|JIT|JIF)/) {
			$regex3 = $hash{$regex3};
		}
		$programa[$counter][0] = ($regex2?$regex2:"");
		$programa[$counter][1] = ($regex3?$regex3:"");

		$counter++;
	}	
}

#salvando um arquivo de texto e imprimindo na tela:
my $file = "programa.txt";
open my $FH, '>', $file or die "Nao consegui criar o arquivo!: $!";
for ($counter = 0; $counter <= $#programa; $counter++) {
	#imprime no arquivo
	print $FH "$programa[$counter][0] $programa[$counter][1]\n";
	#imprime na tela
	print "$programa[$counter][0]  $programa[$counter][1]\n";
}
close $FH or die "Nao consegui fechar o arquivo!: $!";



