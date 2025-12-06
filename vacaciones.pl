%Armar un programa que nos permita conocer donde puede ir de vacaciones una persona.
% Se conoce la siguiente información:

%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


%Desarrollar los siguientes predicados totalmente inversibles:
%puedeIr/3, relaciona una persona, con el lugar y el alojamiento.
puedeIr(Persona,Lugar,Alojamiento):-
    puedeGastar(Persona,CantDias,Presupuesto),
    lugar(Lugar,Alojamiento),
    costoDia(Alojamiento,CostoDiario),
    CostoDiario * CantDias =< Presupuesto.
costoDia(hotel(_,_,CostoDiario),CostoDiario).
costoDia(carpa(CostoDiario),CostoDiario).
costoDia(casa(_,CostoDiario),CostoDiario).
costoDia(quinta(_,_,CostoDiario),CostoDiario).


%2) Conocer las personas que pueden ir a cualquier lugar ya que en todos los lugares
% tienen al menos un alojamiento en donde le alcanza el dinero para ir.
puedeIrACualquierLado(Persona):-
    puedeGastar(Persona,_,_),
    forall(lugar(Lugar,_),puedeIr(Persona,Lugar,_)).