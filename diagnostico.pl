diag_febre():-

	%% inicializacao das variaveis
	% 'x' indica que a questao tn nao foi respondida
	Value = 'x',
	Value2 = 'x',
	Value3 = 'x',
	Value4 = 'x',
	Value5 = 'x',
	Value6 = 'x',
	Value7 = 'x',

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
	nb_setval(Resposta1, Value),
	questao2(Resposta1, Diagnostico_final, Caso),
	writeln(Diagnostico_final),
	writeln(Caso),

	writeln(Value),
	writeln(Value2),
	writeln(Value3),
	writeln(Value4),
	writeln(Value5),
	writeln(Value6),
	writeln(Value7),

	base_diagnostico(Caso, Value, Value2, Value3, X),
	writeln(X).




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
	nb_setval(Resposta2, Value2),
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

base_diagnostico(0, 'n', 'n', 's', 'OBITO').
base_diagnostico(0, 'n','n','s','n','s','x','x','Dermatite com febre').
base_diagnostico(0, 'n','n','s','n','n','s','x','Otite interna').
base_diagnostico(0, 'n','n','s','n','n','n','d','Pneumonia ou bronquiolite').
base_diagnostico(0, 'n','n','s','n','n','n','n','Pneumonia ou bronquiolite').



:- begin_tests(diag).

test(t0, X = 'Diagnostico inconclusivo. Procure um medico') :- diag_febre(X
										     ).
:- end_tests(diag).


