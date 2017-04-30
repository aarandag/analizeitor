programa(X, Analisis):-downcase_atom(X, D), tokenizer(D,B),phrase(oracion(Analisis),B).
tokenizer(A,B):-split_string(A," ",'',B).

%% Reglas gramaticales

oracion(oracion(SN, SV)) --> s_nominal(SN, G, N), s_verbal(SV, G, N).
oracion(oracion(SV)) --> s_verbal(SV, _, _).

s_nominal(sn(DET, SN), Genero, Numero) --> determinante(DET, Genero, Numero), s_nominal2(SN, Genero, Numero).
s_nominal(sn(SN), Genero, Numero) --> s_nominal2(SN, Genero, Numero).

s_nominal2(sn2(SA, SN), G, N) --> s_adjetivo(SA, G, N),  s_nominal2(SN, G, N).
s_nominal2(sn2(S, SN3), G, N) --> sustantivo(S, G, N), s_nominal3(SN3, G, N).
s_nominal2(sn2(S, SA, SN3), G, N) --> sustantivo(S, G, N), s_adjetivo(SA, G, N), s_nominal3(SN3, G, N).

s_nominal3(fsn3, G, N) --> [].
s_nominal3(sn3(SP, SN3), G, N) --> s_preposicional(SP, _, _), s_nominal3(SN3, G, N).
s_nominal3(sn3(SN, SN3), G, N) --> s_nominal(SN, G, N), s_nominal3(SN3, G, N).

s_preposicional(sp(P, SN), G, N) --> preposicion(P),s_nominal(SN,G,N).

s_adjetivo(sadj(SADV, SADJ), G, N) --> s_adverbial(SADV), s_adjetivo(SADJ, G, N).
s_adjetivo(sadj(ADJ, SADJ2), G, N) --> adjetivo(ADJ, G, N), s_adjetivo2(SADJ2, G, N).
s_adjetivo2(fsadj2, G, N) --> [].

s_adjetivo2(sadj2(SP, SADJ2), G, N) --> s_preposicional(SP, _, _), s_adjetivo2(SADJ2, G, N).

s_adverbial(sadv(A, SADV2)) --> adverbio(A), s_adverbial2(SADV2).

s_adverbial2(fsadv2) --> [].
s_adverbial2(sadv2(SP, SADV2)) --> s_preposicional(SP, _, _), s_adverbial2(SADV2).

s_verbal(sv(V, C), G, N) --> verbo(V, predicativo, _, G, N, __), complementos(C).
s_verbal(sv(V, SADJ), G, N) --> verbo(V, copulativo, _, G, N, _), s_adjetivo(SADJ, G, N).
s_verbal(sv(V, SPREP), G, N) --> verbo(V, copulativo,_,G,N,_),s_preposicional(SPREP, _, _).
s_verbal(sv(V, SN), G, N) -->verbo(V, copulativo,_,G,N,_),s_nominal(SN, _, _).
complementos(fc) --> [].
complementos(c(C, CS)) --> complemento(C), complementos(CS).
complemento(c(C)) --> s_nominal(C, _, _) | s_adjetivo(C, _,_) | s_adverbial(C) | s_adjetivo(C, _, _).

%% Vocabulario

determinante(det(X), masculino, singular) --> [X], { member(X, ["ese", "este", "aquel"]) }.
determinante(det(X), femenino, singular) --> [X], { member(X, ["esa", "esta", "aquella", "la"]) }.
determinante(det(X), masculino, plural) --> [X], { member(X, ["los", "esos", "estos", "aquellos", "unos"]) }.
determinante(det(X), femenino, plural) --> [X], { member(X, ["las", "esas", "estas", "aquellas"]) }.
determinante(det(X), _, singular) --> [X], { member(X, ["mi"]) }.
determinante(det(X), _, plural) --> [X], { member(X, ["sus"]) }.

sustantivo(sus(X), masculino, singular) --> [X], { member(X, ["arbol", "chico", "él", "enrique", "amigo", "pueblo"]) }.
sustantivo(sus(X), femenino, singular) --> [X], { member(X, ["chica", "ella", "casa"]) }.
sustantivo(sus(X), masculino, plural) --> [X], { member(X, ["árboles", "chicos", "abuelos"]) }.
sustantivo(sus(X), femenino, plural) --> [X], { member(X, ["chicas", "casas"]) }.
sustantivo(sus(X), _, plural) --> [X], { member(X, ["turistas"]) }.

preposicion(prep(X)) --> [X], { member(X, ["de", "a"]) }.

adverbio(adv(X)) --> [X], { member(X, ["muy", "tan", "pronto"]) }.

verbo(verbo(X), copulativo, indicativo, _, singular, tercera) --> [X], { member(X, ["es", "parece", "está"]) }.
verbo(verbo(X), copulativo, indicativo, _, plural, tercera) --> [X], {member(X, ["son", "parecen", "están"]) }.
verbo(verbo(X), predicativo, indicativo, _, singular, tercera) --> [X], {member(X, ["venderá", "muerde"])}.
verbo(verbo(X), predicativo, indicativo, _, plural, tercera) --> [X], {member(X, ["muerden"])}.

adjetivo(adj(X), masculino, singular) --> [X], {member(X, ["bonito", "guapo", "simpático"])}.
adjetivo(adj(X), femenino, singular) --> [X], {member(X, ["bonita", "guapa", "simpática"])}.
adjetivo(adj(X), masculino, plural) --> [X], {member(X, ["bonitos", "guapos", "simpáticos"])}.
adjetivo(adj(X), femenino, plural) --> [X], {member(X, ["bonitas", "guapas", "simpáticas"])}.

