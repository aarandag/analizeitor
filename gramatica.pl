programa(X, O):-downcase_atom(X, D), tokenizer(D,B),phrase(oracion,B, O).
tokenizer(A,B):-split_string(A," ",'',B).
%% Reglas gramaticales

oracion(oracion(SN, SV)) --> s_nominal(SN, G, N), s_verbal(SV, G, N).
oracion(oracion(SV)) --> s_verbal(SV,_, _).

s_preposicional(G, N) --> preposicion, s_nominal(G, N).
s_nominal(s_nominal(D, SN), Genero, Numero) --> determinante(D, Genero, Numero), s_nominal2(SN, Genero, Numero).
s_nominal(s_nominal(SN),Genero, Numero) --> s_nominal2(SN,Genero, Numero).

s_nominal2(s_nominal(S),G, N) --> sustantivo(S, G, N).
s_nominal2(s_nominal(SA, SN), G, N) --> s_adjetivo(SA, G, N),  s_nominal(SN, G, N).
s_nominal2(s_nominal(S, SA), G, N) --> sustantivo(S, G, N), s_adjetivo(SA, G, N).% @@@La pila :=(

s_adjetivo(adjetivo(A), G, N) --> adjetivo(A, G, N).
s_adjetivo(s_adjetivo(SAV, SADJ), G, N) --> s_adverbial(SADV), s_adjetivo(SADJ, G, N).
%s_adjetivo(G, N) --> s_adjetivo(G, N), s_preposicional(G, N).

s_adverbial(adverbio(A)) --> adverbio(A).

% REVISAR PERSONA
s_verbal(verbo(V), N, G) --> verbo(V, normal, _, G, N, __).
s_verbal(s_verbal(V, SN), G, N) --> verbo(V, normal, _, G, N, _), s_nominal(SN, _, _).
s_verbal(s_verbal(V, SA), G, N) --> verbo(V, copulativo, _, G, N, _), s_adjetivo(SA, G, N).
%% Vocabulario

determinante(masculino, singular) --> ["ese"].
determinante(masculino, plural) --> ["esos"].
determinante(determinante(esa), femenino, singular) --> ["esa"].
determinante(femenino, plural) --> ["esas"].
determinante(masculino, singular) --> ["este"].
determinante(masculino, plural) --> ["estos"].
determinante(femenino, singular) --> ["esta"].
determinante(femenino, plural) --> ["estas"].
determinante(masculino, singular) --> ["aquel"].
determinante(masculino, plural) --> ["aquellos"].
determinante(femenino, singular) --> ["aquella"].
determinante(femenino, plural) --> ["aquellas"].

sustantivo(masculino, singular) --> ["él"].
sustantivo(femenino, singular) --> ["ella"].
sustantivo(sustantivo(casa),femenino, singular) --> ["casa"].
sustantivo(femenino, plural) --> ["casas"].
sustantivo(masculino, plural) --> ["cojones"].

adverbio(muy) --> ["muy"].

preposicion --> ["a"].
preposicion --> ["de"].

% verbo(tipo, modo, genero, numero, persona)
verbo(normal, indicativo, _, singular, tercera) --> ["juega"].

verbo(verbo(es), copulativo, indicativo, _, singular, tercera) --> ["es"].
verbo(copulativo, indicativo, _, plural, tercera) --> ["son"].

verbo(copulativo, indicativo, _, singular, tercera) --> ["parece"].
verbo(copulativo, indicativo, _, plural, tercera) --> ["parecen"].

verbo(copulativo, indicativo, _, singular, tercera) --> ["está"].
verbo(copulativo, indicativo, _, plural, tercera) --> ["están"].

adjetivo(masculino, singular) --> ["bonito"].
adjetivo(adjetivo(bonita),femenino, singular) --> ["bonita"].
adjetivo(masculino, plural) --> ["bonitos"].
adjetivo(femenino, plural) --> ["bonitas"].
adjetivo(feminino, singular) --> ["fea"].

