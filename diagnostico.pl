diag_febre(Caso, R1, R2, R3, R4, R5, R6, R7):-

	writeln('### Progra de diagnostico para febre ###'),
	writeln('### Dr. Thiago Kira ###'),
	writeln('### CRM 78750 ###'),
	writeln('### Consultorio UEM ###'),
	writeln(' 1 - Apresenta algum dos seguintes sintomas? '),
	writeln(' * Respiracao anormalmente rapida'),
	writeln(' * Respiracao ruidosa ou dificil'),
	writeln(' * Sonolencia ou irritabilidade'),
	writeln(' s - sim / n - nao'),
	read(R1),
	questao2(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso),
	writeln(' ### DIAGNOSTICO FINAL ### '),
	writeln(''),
	writeln(Diagnostico_final).

questao2(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso) :-
	R1 == 's',
	Caso = 1,
	Diagnostico_final = 'Chame uma ambulancia';

	writeln(' 2 - Apresenta algum dos seguintes sintomas? '),
	writeln(' * Nao quer beber'),
	writeln(' * Vomito persistente'),
	writeln(' * Temperatura superior a 39 graus'),
	writeln(' s - sim	/ n - nao'),
	read(R2),
	questao3(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso).

questao3(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso) :-
	R2 == 's',
	Caso = 1,
	Diagnostico_final = 'Procure orientacao medica';
	write(' 3 - Temperatura maior a 38 graus?'), nl,
	write(' s - sim / n - nao / d - nao sei '),nl,
	read(R3),
	questao4(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso).

questao4(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso) :-
	R3 == 'd',
	Caso = 0,
	Diagnostico_final = 'Faca mais exames';
	R3 == 'n',
	Caso = 0,
	Diagnostico_final = 'Doenca nao identificada';
	writeln(' 4 - Tem menos de 6 meses de idade? '),
	writeln(' s - sim / n - nao'),
	read(R4),
	questao5(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso).

questao5(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso) :-
	R4 == 's',
	Caso = 0,
	Diagnostico_final = 'Procure um medico. Caso incomum .Pode ser uma doenca seria ';
	writeln(' 5 - Apresenta alguma erupcao na pele '),
	writeln(' s - sim / n - nao '),
	read(R5),
	questao6(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso).

questao6(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso) :-
	R5 == 's',
	Caso = 1,
	Diagnostico_final = 'Dermatite com febre. Consulte um medico';
	writeln(' 6 - Chora, puxa uma orelha ou acorda gritando? '),
	writeln(' s - sim / n -nao '),
	read(R6),
	questao7(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso).

questao7(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso) :-
	R6 == 's',
	Caso = 1,
	Diagnostico_final = 'Otite interna. Consulte um medico';
	writeln(' 7 - Ritmo respiratorio acima do normal?'),
	writeln(' s - sim / n - nao / d - nao sei'),
	read(R7),
	questao8(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso).

questao8(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso) :-
	R7 == 'd',
	Caso = 0,
	Diagnostico_final = 'Faca mais exames';
	R7 == 's',
	Caso = 1,
	Diagnostico_final = 'Pneumonia ou bronquite. Procure um medico';
	R7 == 'n',
	Caso = 0,
	Diagnostico_final = 'Diagnostico inconclusivo. Procure um medico'.


% Base de conhecimento para diagnostico
% Caso o diagnostico final seja inconclusivo buscas-se um possivel
% diagnostico nesta base de conhecimento
%

falso(0).
verdadeiro(1).

teste() :-
	diag_febre(Caso, R1, R2, R3, R4, R5, R6, R7)  , !, (
	falso(Caso) ->( writeln(''),
		     writeln(' ### DIAGNOSTICO ALTERNATIVO ### '),
		     writeln(''),
		     diag_alternativo(R1, R2, R3, R4, R5, R6, R7),
		     nl)),
	verdadeiro(Caso) -> writeln(' ### FIM DO DIAGNOSTICO ### ').

diag_alternativo(R1, R2, R3, R4, R5, R6, R7) :-
        (var(R7), var(R4)) -> (
	d(R1, R2, R3, _, _, _, _, Condicao1, Diagnostico1),
	write('se tiver '), write(Condicao1), write(' pode estar '), writeln(Diagnostico1));
	(var(R7)) -> (
	d(R1, R2, R3, R4, _, _, _, Condicao1, Diagnostico1),
	write('se tiver '), write(Condicao1), write(' pode estar '), writeln(Diagnostico1));
	d(R1, R2, R3, R4, R5, R6, R7, Condicao1, Diagnostico1),
	write('se tiver '), write(Condicao1), write(' pode estar '), writeln(Diagnostico1).


% BASE DE CONHECIMENTO

d(n, n, n, n, s, s, s, 'Gonorreia', 'com Aids').
d(n, n, n, n, s, s, s, 'bem ruim', 'em estado vegetativo').
d(n, n, s, s, s, s, s, 'Dor de cabeca', 'com hemorragia').
d(n, n, s, n, n, n, d, 'com Fome', 'Desnutrido').



:- begin_tests(diag).

test(t0, X = 'Diagnostico inconclusivo. Procure um medico') :- diag_febre(X).

:- end_tests(diag).


