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

sub montador { 
	while (<>) {
		$_ =~ s/[#].*//;
		if ($_ =~ /\w/) {
			$_ =~ /\s*(.*\:)?\s*([A-Z]{2,4})\s*(\w*)/;
			my @regex = ($1, $2, $3);

			if ($regex[0]) {
				$regex[0] =~ s/\s*[:].*//;
				$hash{$regex[0]} = $counter;
			}
			if ($regex[1] =~ /(JMP|JIT|JIF)/) {
				$regex[2] = $hash{$regex[2]};
			}
			$programa[$counter][0] = $regex[1];
			$programa[$counter][1] = $regex[2];

			$counter++;
		}
	}
	return @programa;
}

1

