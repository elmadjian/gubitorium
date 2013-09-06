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

use feature "switch";
use strict;
use warnings;
use utf8;

#==== VARIAVEIS =====
my @programa;           #pilha de instrucoes
my @dados;              #pilha de dados
my @execucao;           #pilha de execucao
my @memoria;            #vetor de memoria
my $pcounter = 0;          #"ponteiro" de instrucoes

#==== PROGRAMA ======

my $file = "teste.txt";
#Escrevendo a pilha de instrucoes
open my $FH, '<', $file or die "Não consegui abrir o arquivo: $!";
while (<$FH>) {
	chomp;
	push @programa, $_;
	#ajustando o ponteiro de instrucoes
}
close $FH or die "Não consegui fechar o arquivo: $!";

#Testando o array de instrucoes
foreach my $coisa (@programa) {
	print "$coisa\n";
}

#Convencoes:
my $TRUE = 1;
my $FALSE = 0;
#

#loop eterno do programa
for (my $opcode = "nothing"; $opcode ne "END"; $pcounter++) {

	my $valor;

	if ($programa[$pcounter] =~ /([a-zA-Z]{2,4})/) {
		$opcode = $1;
		print "OP: $opcode\n";
	}
	if ($programa[$pcounter] =~ /([0-9]+)/) {
		$valor = $1;
		print "VL: $valor\n";
	}
	given ($opcode) {
		when ('PUSH') {&psh ($valor);}
		when ('POP') {&pp;}
		when ('DUP') {&dup;}
		when ('ADD') {&add;}
		when ('SUB') {&sub;}
		when ('MUL') {&mul;}
		when ('DIV') {&div;}
		when ('JMP') {&jmp ($valor);}
		when ('JIT') {&jit ($valor);}
		when ('JIF') {&jif ($valor);}
		when ('EQ')  {&eq;}
		when ('GT')  {&gt;}
		when ('GE')  {&ge;}
		when ('LT')  {&lt;}
		when ('LE')  {&le;}
		when ('NE')  {&ne;}
		when ('STO') {&sto ($valor);}
		when ('RCL') {&rcl ($valor);}
		when ('PRN') {&prn;}
	}
	for(my $i = @dados-1; $i >=0; $i--) {print "DADOS[$i]: $dados[$i]\n";}
	for(my $i = @memoria-1; $i >=0; $i--) {print "MEM[$i]: $memoria[$i]\n";}
	print "----------\n";

}

#DEBUG...
foreach my $treco (@memoria) {
	print "memoria_ $treco\n";
}
foreach my $xis (@dados) {
	print "dados_ $xis\n";
}





#==== SUB-ROTINAS ====
#

#==== Manipulacao de pilhas
#PUSH
sub psh {
	push @dados, $_[0];
}

#POP
sub pp {
	pop @dados;
}

#DUP
sub dup {
	my $valor = $dados[-1];
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
	push @dados, ($valor2 - $valor1);
}

#MUL
sub mul {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, ($valor2 * $valor1);
}

#DIV
sub div {
	my $valor1 = pop @dados;
	my $valor2 = pop @dados;
	push @dados, ($valor2 / $valor1);
}

#==== Desvios (condicionais ou nao)
#JMP
sub jmp {
	$pcounter = $_[0]-1;
}

#JIT
sub jit {
	$pcounter = $_[0]-1 if ((pop @dados) == $TRUE);
}

#JIF
sub jif {
	$pcounter = $_[0]-1 if ((pop @dados) == $FALSE);
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
	$memoria[$_[0]] = pop @dados;
}

#RCL
sub rcl {
	push @dados, $memoria[$_[0]];
}

#==== Execucao e Terminal
#PRN
sub prn {
	my $valor = pop @dados;
	print "$valor\n";
}



