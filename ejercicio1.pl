contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
honesto(roque).
ingeniero(ana).
habla(roque,frances).
habla(ana,ingles).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).

ambicioso(Persona) :-
    contador(Persona),
    joven(Persona).

tieneExperiencia(Persona) :-
    trabajoEn(Persona, _).

esProfesional(Persona):-
    contador(Persona).
esProfesional(Persona):-
    abogado(Persona).
esProfesional(Persona):-
    ingeniero(Persona).

%1. puedeAndar(Sector,Persona).
puedeAndar(comercioExterior,Persona):-
    ambicioso(Persona).
puedeAndar(contaduria,Persona):-
    honesto(Persona),
    contador(Persona).
puedeAndar(ventas,Persona):-
    ambicioso(Persona),
    tieneExperiencia(Persona).
puedeAndar(ventas,lucia).

%2. 
puedeAndar(proyectos,Persona):-
    ingeniero(Persona).
    tieneExperiencia(Persona).
puedeAndar(proyectos,Persona):-
    abogado(Persona),
    joven(Persona).
puedeAndar(logistica,Persona):-
    esProfesional(Persona),
    requisitosLogistica(Persona).
requisitosLogistica(Persona):-
    joven(Persona).
requisitosLogistica(Persona):-
    trabajoEn(omni,Persona).

%3.a Va para proyecto no para logística
ingeniero(enrique). 
trabajoEn(enrique,hacienda).

ambicioso(laura).
trabajoEn(laura,cencosud).


%Relaciones familiares
madre(mona,homero).
madre(jaqueline,marge).
madre(marge,maggie).
madre(marge,bart).
madre(marge,lisa).
padre(abraham,herbert).
padre(abraham,homero).
padre(ciancy,jaqueline).
padre(homero,maggie).
padre(homero,bart).
padre(homero,lisa).

%hermano(Hermano1,Hermano2).
hijoDe(Hijo,Padre):-
    padre(Padre,Hijo).
hijoDe(Hijo,Padre):-
    madre(Padre,Hijo).
hermano(Hermano1,Hermano2):-
    hijoDe(Hermano1,Padre),
    hijoDe(Hermano2,Padre),
    Hermano1 \= Hermano2.

medioHermano(Hermano1,Hermano2):-
    hermano(Hermano1,Hermano2),
    padre(Padre1,Hermano1),
    padre(Padre2,Hermano2),
    \+ (madre(Madre1,Hermano1), madre(Madre1,Hermano2)).
medioHermano(Hermano1,Hermano2):-
    hermano(Hermano1,Hermano2),
    madre(Madre1,Hermano1),
    madre(Madre2,Hermano2),
    \+ (padre(Padre1,Hermano1), padre(Padre1,Hermano2)).

hijoUnico(Hijo):-
    hijoDe(Hijo,Padre),
    \+ hermano(Hijo,Otro).

tio(Tio,Sobrino):-
    hermano(Tio,Padre),
    hijoDe(Sobrino,Padre).


%Transporte
transporte(juan,camina).
transporte(marcela,subte(a)).
transporte(pepe,colectivo(160,d)).
transporte(elena,colectivo(76)).
transporte(maria,auto(500,fiat,2014)).
transporte(ana,auto(fiesta,ford,2020)).
transporte(roberto,auto(qubo,fiat,2015)).
manejaLento(manuel).
manejaLento(ana).

%Se mueve en fiat
vieneEnFiat(Persona):-
    transporte(Persona,auto(Modelo,fiat,Year)).
tardaMucho(Persona):-
    transporte(Persona,camina).
tardaMucho(Persona):-
    manejaLento(Persona),
    transporte(Persona,auto(Modelo,Marca,Year)).


viajaEnColectivo(Persona):-
    transporte(Persona,colectivo(Linea,Ramal)).
viajaEnColectivo(Persona):-
    transporte(Persona,colectivo(Linea)).
personasEnColectivo(Personas):-
    findall(Persona,viajaEnColectivo(Persona),Personas).
