%Dados los siguientes predicados resolver un ancestro, que te diga si una persona es ancestra de otra
progenitor(abraham,homero).
progenitor(jaquelin,marge).
progenitor(homero,bart).
progenitor(homero,lisa).
progenitor(homero,maggie).
progenitor(marge,bart).
progenitor(marge,lisa).
progenitor(marge,maggie).

ancestro(Ancestro,Persona):-
    progenitor(Ancestro,Persona).
ancestro(Ancestro,Persona):-
    progenitor(OtroAncestro,Persona),
    ancestro(Ancestro,OtroAncestro).