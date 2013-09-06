#!/usr/bin/perl 
#===============================================================================
#
#         FILE: vm.pl
#
#        USAGE: ./vm.pl  
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
#      CREATED: 09/05/2013 10:49:55
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

#==== VARIAVEIS =====
my @programa;           #pilha de instrucoes
my @dados;              #pilha de dados
my @execucao;           #pilha de execucao
my @memoria;            #vetor de memoria
my $topo = 0;           #"ponteiro" de instrucoes

#==== PROGRAMA ======

my $file = "teste.txt";
#Escrevendo a pilha de instrucoes
open my $linha, '<', $file or die "Não consegui abrir o arquivo: $!";
while (<$linha>) {
	chomp;
	push @programa, $_;
	#ajustando o ponteiro de instrucoes
	$topo++;
}
close $linha or die "Não consegui fechar o arquivo: $!";

#Testando o array de instrucoes
foreach my $coisa (@programa) {
	print "$coisa\n";
}






#==== SUB-ROTINAS ====
#
#Convencoes:
my $TRUE = 1;
my $FALSE = 0;
#
#==== Manipulacao de pilhas
#PUSH
sub psh {
	push @dados, my $valor;
}

#POP
sub pp {
	pop @dados;
}

#DUP
sub dup {
	my $valor = @dados;
	push @dados, $valor;
}

#==== Operacoes Aritmeticas
#ADD
sub add {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, ($valor1 + $valor2);
}

#SUB
sub sub {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, ($valor1 - $valor2);
}

#MUL
sub mul {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, ($valor1 * $valor2);
}

#DIV
sub div {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, ($valor1 / $valor2);
}

#==== Desvios (condicionais ou nao)
#JMP
sub jmp {
	$topo = my $valor;
}

#JIT
sub jit {
	$topo = my $valor if (pop @dados == $TRUE);
}

#JIF
sub jif {
	$topo = my $valor if (pop @dados == $FALSE);
}

#==== Comparacoes
#EQ
sub eq {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, $TRUE if ($valor1 == $valor2);
	push @dados, $FALSE if ($valor1 != $valor2);
}
#GT
sub gt {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	if ($valor1 > $valor2) {push @dados, $TRUE;}
	else {push @dados, $FALSE;}
}

#GE
sub ge {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	if ($valor1 >= $valor2) {push @dados, $TRUE;}
	else {push @dados, $FALSE;}
}
#LT
sub lt {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	if ($valor1 < $valor2) {push @dados, $TRUE;}
	else {push @dados, $FALSE;}
}
#LE
sub le {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	if ($valor1 <= $valor2) {push @dados, $TRUE;}
	else {push @dados, $FALSE;}
}
#NE
sub ne {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, $TRUE if ($valor1 != $valor2);
	push @dados, $FALSE if ($valor1 == $valor2);
}

#==== Acesso a memoria
#STO
sub sto {
	my $valor;
	$memoria[$valor] = pop @dados;
}

#RCL
sub rcl {
	my $valor;
	push @dados, $memoria[$valor];
}

#==== Execucao e Terminal
#END
sub prn {
	print pop @dados;
}



