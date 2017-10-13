diag_febre(Caso, R1, R2, R3, R4, R5, R6, R7, Str):-

	writeln('### Progra de diagnostico para febre ###'),
	writeln('### Dr. Thiago Kira ###'),
	writeln('### CRM 78750 ###'),
	writeln('### Consultorio UEM ###'),
	writeln(' 1 - Apresenta algum dos seguintes sintomas? '),
	writeln(' * Respiracao anormalmente rapida'),
	writeln(' * Respiracao ruidosa ou dificil'),
	writeln(' * Sonolencia ou irritabilidade'),
	writeln(' s - sim / n - nao'),
	read(Str, R1),
	questao2(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso, Str),
	writeln(' ### DIAGNOSTICO FINAL ### '),
	writeln(''),
	writeln(Diagnostico_final).

questao2(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str) :-
	R1 == 's',
	Caso = 0,
	Diagnostico_final = 'Caso serio. Chame uma ambulancia';

	writeln(' 2 - Apresenta algum dos seguintes sintomas? '),
	writeln(' * Nao quer beber'),
	writeln(' * Vomito persistente'),
	writeln(' * Temperatura superior a 39 graus'),
	writeln(' s - sim	/ n - nao'),
	read(Str, R2),
	questao3(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso, Str).

questao3(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str) :-
	R2 == 's',
	Caso = 0,
	Diagnostico_final = 'Procure orientacao medica';
	write(' 3 - Temperatura maior a 38 graus?'), nl,
	write(' s - sim / n - nao / d - nao sei '),nl,
	read(Str, R3),
	questao4(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str).

questao4(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str) :-
	R3 == 'd',
	Caso = 0,
	Diagnostico_final = 'Faca mais exames';
	R3 == 'n',
	Caso = 0,
	Diagnostico_final = 'Doenca nao identificada';
	writeln(' 4 - Tem menos de 6 meses de idade? '),
	writeln(' s - sim / n - nao'),
	read(Str, R4),
	questao5(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str).

questao5(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str) :-
	R4 == 's',
	Caso = 0,
	Diagnostico_final = 'Procure um medico. Caso incomum .Pode ser uma doenca seria ';
	writeln(' 5 - Apresenta alguma erupcao na pele '),
	writeln(' s - sim / n - nao '),
	read(Str, R5),
	questao6(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso, Str).

questao6(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso, Str) :-
	R5 == 's',
	Caso = 1,
	Diagnostico_final = 'Dermatite com febre. Consulte um medico';
	writeln(' 6 - Chora, puxa uma orelha ou acorda gritando? '),
	writeln(' s - sim / n -nao '),
	read(Str, R6),
	questao7(R1, R2, R3, R4, R5, R6, R7,  Diagnostico_final, Caso, Str).

questao7(R1, R2, R3, R4, R5, R6, R7, Diagnostico_final, Caso, Str) :-
	R6 == 's',
	Caso = 1,
	Diagnostico_final = 'Otite interna. Consulte um medico';
	writeln(' 7 - Ritmo respiratorio acima do normal?'),
	writeln(' s - sim / n - nao / d - nao sei'),
	read(Str, R7),
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

diagnostico(Arquivo) :-
        open(Arquivo, read, Str),
	diag_febre(Caso, R1, R2, R3, R4, R5, R6, R7, Str)  , !, (
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

d(n, n, n, n, s, s, s, 'rejeitando comido', 'com garganta infeccionada').
d(n, n, n, n, s, s, d, 'com gripe ou resfriado', 'com sarampo').
d(n, n, n, n, s, s, d, 'com tosse ou coriza', 'com resfriado').
d(n, n, n, n, s, s, d, 'com irratabilidade incomum', 'Meningite').
d(n, n, n, n, s, s, d, 'rejeitando comida solida', 'com infeccao de garganta').
d(n, n, d, n, s, s, d, 'com inchaco em um lado da face', 'com caxumba').
d(n, n, d, n, s, s, d, 'ficado muito tempo no sol', 'superaquecido').
d(n, n, d, n, s, s, d, 'com vomito persistente', 'diarreia seria, chame uma ambulancia').
d(n, n, d, n, s, s, d, 'com tosse', 'com bronquiolite').
d(n, n, d, n, s, s, d, 'vomito normal', 'apenas vomito, nada serio').
d(n, n, d, n, s, s, d, 'com vomito seguido por crise de tosse', 'coqueluche').
d(n, n, n, n, s, s, n, 'vomito sem diarreia', 'com meningite').
d(n, n, n, n, s, s, s, 'vomito com diarreia', 'com gastroenterite').
d(n, n, s, s, s, s, s, 'Dor de cabeca', 'com hemorragia').
d(n, n, s, n, n, n, d, 'com Fome', 'Desnutrido').
d(s, n, n, n, s, s, s, 'rejeitando comido', 'com garganta infeccionada').
d(s, n, n, n, s, s, d, 'com gripe ou resfriado', 'com sarampo').
d(s, n, n, n, s, s, d, 'com tosse ou coriza', 'com resfriado').
d(s, n, n, n, s, s, d, 'com irratabilidade incomum', 'Meningite').
d(s, n, n, n, s, s, d, 'rejeitando comida solida', 'com infeccao de garganta').
d(s, n, d, n, s, s, d, 'com inchaco em um lado da face', 'com caxumba').
d(s, n, d, n, s, s, d, 'ficado muito tempo no sol', 'superaquecido').
d(n, s, d, n, s, s, d, 'com vomito persistente', 'diarreia seria, chame uma ambulancia').
d(n, s, d, n, s, s, d, 'com tosse', 'com bronquiolite').
d(n, s, d, n, s, s, d, 'vomito normal', 'apenas vomito, nada serio').
d(n, s, d, n, s, s, d, 'com vomito seguido por crise de tosse', 'coqueluche').
d(n, s, n, n, s, s, n, 'vomito sem diarreia', 'com meningite').
d(n, s, n, n, s, s, s, 'vomito com diarreia', 'com gastroenterite').
d(n, s, s, s, s, s, s, 'Dor de cabeca', 'com hemorragia').
d(s, n, s, n, n, n, d, 'com Fome', 'Desnutrido').
d(n,n,s,s,n,n,d, 'com diarreia', 'com gastroenterite').
d(n,n,s,s,n,s,d, 'tomando algum medicamento', 'fazendo efeito colateral').
d(n,n,s,s,s,n,d, 'vomito esverdeado', 'com obstrucao intestinal').
d(n,n,s,s,s,n,n, 'com fezes palidas e urina escura', 'com Hepatite').
d(n,n,s,s,n,n,d, 'fazendo xixi na cama', 'com Meningite').
d(n,n,s,s,n,n,n, 'roubando coisas de casa', 'Usando dogras').
d(n,n,s,n,n,n,d, 'caindo no chao inconsciente', 'com Hipoglecimia').
d(n,n,s,n,n,n,d, 'com urina verde ou azul', 'com Problemas alimentares').
d(n,n,s,n,n,n,d, 'com fezes com sangue', 'com falha instestinal').
d(n,n,s,n,n,n,d, 'com dor ao urinar', 'com infeccao do sistema urinario').
d(n,n,s,n,n,n,n, 'inchaço dolorido na verilia', 'com Hernia inguinal estrangulada').
d(n,n,s,n,n,n,n, 'com dor na lingua', 'com Ulceras bucais').
d(n,n,s,n,n,n,n, 'gengivas dolorias vermelhas', 'denticao').
d(n,n,s,n,n,n,n, 'com tosse ou coriza', 'com Febre').
d(n,n,s,n,n,n,n, 'com febre', 'com Diarreia').
d(n,n,s,n,n,n,n, 'anormalmente sonolento', 'com Vomito').
d(n,n,s,n,n,n,n, 'coceira', 'com Dermatite com febre').


:- begin_tests(diag).

test(1) :- diagnostico('teste1.txt').
test(2) :- diagnostico('teste2.txt').

:- end_tests(diag).
