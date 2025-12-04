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