diag_febre():-

	%% inicializacao das variaveis
	% 'x' indica que a questao tn nao foi respondida
	nb_setval(t1, 'x'),
	nb_setval(t2, 'x'),
	nb_setval(t3, 'x'),
	nb_setval(t4, 'x'),
	nb_setval(t5, 'x'),
	nb_setval(t6, 'x'),
	nb_setval(t7, 'x'),

	writeln('### Progra de diagnostico para febre ###'),
	writeln('### Dr. Thiago Kira ###'),
	writeln('### CRM 78750 ###'),
	writeln('### Consultorio UEM ###'),
	writeln(' 1 - Apresenta algum dos seguintes sintomas? '),
	writeln(' * Respiracao anormalmente rapida'),
	writeln(' * Respiracao ruidosa ou dificil'),
	writeln(' * Sonolencia ou irritabilidade'),
	writeln(' s - sim / n - nao'),

	read(Resposta1),
	nb_setval(t1, Resposta1),
	questao2(Resposta1, Diagnostico_final, Caso),
	writeln(' ### DIAGNOSTICO FINAL ### '),
	writeln(Diagnostico_final),
	writeln(Caso),
	pergunta(Caso).

questao2(R1, Diagnostico_final, Caso) :-
	R1 == 's',
	Caso = 1,
	Diagnostico_final = 'Chame uma ambulancia';

	writeln(' 2 - Apresenta algum dos seguintes sintomas? '),
	writeln(' * Nao quer beber'),
	writeln(' * Vomito persistente'),
	writeln(' * Temperatura superior a 39 graus'),
	writeln(' s - sim	/ n - nao'),
	read(Resposta2),
	nb_setval(t2, Resposta2),
	questao3(Resposta2, Diagnostico_final, Caso).

questao3(R2, Diagnostico_final, Caso) :-
	R2 == 's',
	Caso = 1,
	Diagnostico_final = 'Procure orientacao medica';
	write(' 3 - Temperatura maior a 38 graus?'), nl,
	write(' s - sim / n - nao / d - nao sei '),nl,
	read(Resposta3),
	nb_setval(t3, Resposta3),
	questao4(Resposta3, Diagnostico_final, Caso).

questao4(R3, Diagnostico_final, Caso) :-
	R3 == 'd',
	Caso = 0,
	Diagnostico_final = 'Faca mais exames';
	R3 == 'n',
	Caso = 0,
	Diagnostico_final = 'Doenca nao identificada';
	writeln(' 4 - Tem menos de 6 meses de idade? '),
	writeln(' s - sim / n - nao'),
	read(Resposta4),
	nb_setval(t4, Resposta4),
	questao5(Resposta4, Diagnostico_final, Caso).

questao5(R4, Diagnostico_final, Caso) :-
	R4 == 's',
	Caso = 0,
	Diagnostico_final = 'Procure um medico. Caso incomum .Pode ser uma doenca seria ';
	writeln(' 4 - Apresenta alguma erupcao na pele '),
	writeln(' s - sim / n - nao '),
	read(Resposta5),
	nb_setval(t5, Resposta5),
	questao6(Resposta5, Diagnostico_final, Caso).

questao6(R5, Diagnostico_final, Caso) :-
	R5 == 's',
	Caso = 1,
	Diagnostico_final = 'Dermatite com febre. Consulte um medico';
	writeln(' 5 - Chora, puxa uma orelha ou acorda gritando? '),
	writeln(' s - sim / n -nao '),
	read(Resposta6),
	nb_setval(t6,Resposta6),
	questao7(Resposta6, Diagnostico_final, Caso).

questao7(R6, Diagnostico_final, Caso) :-
	R6 == 's',
	Caso = 1,
	Diagnostico_final = 'Otite interna. Consulte um medico';
	writeln(' 6 - Ritmo respiratorio acima do normal?'),
	writeln(' s - sim / n - nao / d - nao sei'),
	read(Resposta7),
	nb_setval(t7, Resposta7),
	questao8(Resposta7, Diagnostico_final, Caso).

questao8(R7, Diagnostico_final, Caso) :-
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

pergunta(A):-
	falso(A),
	teste2();
	verdadeiro(A),
	writeln('fim').

teste2():-
	teste(C),
	writeln(C).

teste(B) :- B = 'ruim'.
teste(B) :- B = 'muito ruim'.

:- begin_tests(diag).

test(t0, X = 'Diagnostico inconclusivo. Procure um medico') :- diag_febre(X).

:- end_tests(diag).


