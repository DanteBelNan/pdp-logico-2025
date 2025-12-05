/*
**Listas - Recursividad - Explosión Combinatoria**
1. encolar(E,L,LConE) relaciona un elemento con una lista y 
la lista que resulta de agregar el elemento al final.
*/

encolar(Elem,Lista,NewLista):-
    append(Lista,[Elem],NewLista).

% maximo(L,Max) relaciona una lista con el elemento más grande. Realizarlo sin recursividad
maximo(Lista,Max):-
    member(Max,Lista),
    forall(member(Elem,Lista),Max>=Elem).

% intersección(L1,L2,L1nL2) Relaciona la lista L1 con la L2 y da su intersección
perteneceAmbas(Elem,L1,L2):-
    member(Elem,L1),
    member(Elem,L2).
interseccion(L1,L2,L1nL2):-
    findall(Elem,perteneceAmbas(Elem,L1,L2),L1nL2).

% esCreciente(L) Dice si el orden de los numeros de L es creciente
esCreciente([]).
esCreciente([_]).
esCreciente([Cabeza,Cuello|Cola]):-
    Cabeza < Cuello,
    esCreciente([Cuello|Cola]).

% sublistaMayoresA(L,Elem,Mayores) relaciona una lista con un elemento
% y da todas las sublistas que son mayores al elemento Elem
sublistaMayoresA(Lista,MayorA,Mayores):-
    findall(Elem, (member(Elem,Lista), Elem>MayorA),Mayores).