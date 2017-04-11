%% Reglas gramaticales

oracion --> s_nominal(_, _), s_verbal.

s_nominal(Genero, Numero) --> determinante(Genero, Numero), s_nominal2(Genero, Numero).
s_nominal(Genero, Numero) --> s_nominal2(Genero, Numero).

s_nominal2(G, N) --> adjetivo(G, N), s_nominal(G, N).
%% s_nominal2(G, N) --> s_nominal(G, N), adjetivo(G, N). @@@La pila se va a la puta :=( 
s_nominal2(G, N) --> sustantivo(G, N).

s_verbal --> verbo.
s_verbal --> verbo, s_nominal(_, _).

%% Vocabulario

determinante(masculino, singular) --> [ese].
determinante(femenino, singular) --> [esa].
determinante(masculino, singular) --> [este].
determinante(femenino, singular) --> [esta].
determinante(masculino, singular) --> [aquel].
determinante(femenino, singular) --> [aquella].

sustantivo(masculino, singular) --> [él].
sustantivo(femenino, singular) --> [ella].
sustantivo(femenino, singular) --> [casa].

verbo --> [juega].
verbo --> [es].

adjetivo(masculino, singular) --> [bonito].
adjetivo(femenino, singular) --> [bonita].
adjetivo(masculino, plural) --> [bonitos].
adjetivo(femenino, singular) --> [bonitas].
