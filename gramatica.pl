%% Reglas gramaticales
programa(X):-downcase_atom(X, D), tokenizer(D,B),phrase(oracion,B).
oracion --> s_nominal(_, _), s_verbal.

s_nominal(Genero, Numero) --> determinante(Genero, Numero), s_nominal2(Genero, Numero).
s_nominal(Genero, Numero) --> s_nominal2(Genero, Numero).

s_nominal2(G, N) --> sustantivo(G, N).

s_nominal2(G, N) --> adjetivo(G, N), s_nominal(G, N).
s_nominal2(G, N) --> sustantivo(G, N), adjetivo(G, N).% @@@La pila :=(

s_verbal --> verbo.
s_verbal --> verbo, s_nominal(_, _).

%% Vocabulario

determinante(masculino, singular) --> ["ese"].
determinante(masculino, plural) --> ["esos"].
determinante(femenino, singular) --> ["esa"].
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
sustantivo(femenino, singular) --> ["casa"].
sustantivo(femenino, plural) --> ["casas"].

verbo --> ["juega"].
verbo --> ["es"].

adjetivo(masculino, singular) --> ["bonito"].
adjetivo(femenino, singular) --> ["bonita"].
adjetivo(masculino, plural) --> ["bonitos"].
adjetivo(femenino, plural) --> ["bonitas"].

tokenizer(A,B):-split_string(A," ",'',B).





