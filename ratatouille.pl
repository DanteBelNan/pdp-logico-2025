/*

¡Bonjour! En una ciudad donde ratas y humanos saben cocinar, por supuesto que se necesita 
un sistema que ponga orden en este asunto.

De las ratas sabemos su nombre y dónde viven, por ahora nuestras estrellas son:

- Remy, que vive en gusteaus
- Emile, que vive en chezMilleBar
- Django, que vive en la pizzeriaJeSuis

Sobre los humanos tenemos más información, de cada persona sabemos su nombre, qué platos 
saben cocinar y cuánta experiencia tienen haciendo cada plato (la experiencia la evaluamos como 
numérica de 1 a 10, siendo 1 lo más básico y 10 el mayor expertise), por ejemplo:
- Linguini sabe cocinar ratatouille (tiene una experiencia de 3) y 
  también sabe cocinar sopa con una experiencia de 5
- Colette sabe cocinar salmón asado con una experiencia de 9
- Horst sabe cocinar ensalada rusa con una experiencia de 8

También sabemos quién trabaja en cada restaurante:

- Linguini, Colette, Horst y Skinner trabajan en gusteaus
- Amelie trabaja en cafe des 2 Moulins
*/

%vive(Rata,Restaurante)
vive(remy,gusteaus).
vive(emile,chezMilleBar).
vive(django,pizerriaJeSuis).

%cocina(Cocinero,Plato,Experiencia)
cocina(linguini,ratatouille,3).
cocina(linguini,sopa,5).
cocina(colette,salmon,9).
cocina(horst,ensaladaRusa,8).

%trabaja(Cocinero,Restaurante).
trabaja(linguini,gusteaus).
trabaja(colette,gusteaus).
trabaja(horst,gusteaus).
trabaja(skinner,gusteaus).
trabaja(amelie,cafe_des_2_moulins).

/* 
Desarrollá los siguientes requerimientos, asegurando que los predicados principales 
sean completamente inversibles:
*/

% Saber si un plato está en el menú de un restaurante, 
% que es cuando alguno de los empleados lo sabe cocinar.
estaEnMenu(Plato,Restaurante):-
    trabaja(Cocinero,Restaurante),
    cocina(Cocinero,Plato,_).

/*
Saber quién cocina bien un determinado plato, 
que es verdadero para una persona si su experiencia preparando ese plato es mayor a 7, 
ó si tiene un tutor que cocina bien el plato. 
Nos contaron que Linguini tiene como tutor a toda rata que viva en el lugar donde trabaja, 
además que Amelie es la tutora de Skinner.
También se sabe que remy cocina bien cualquier plato que exista,
 y el resto de las ratas no cocina bien nada.
*/
cocinaBien(Cocinero,Plato):-
    cocina(Cocinero,Plato,Experiencia),
    Experiencia > 7.
cocinaBien(Cocinero,Plato):-
    tutor(Cocinero,Tutor),
    cocinaBien(Tutor,Plato).
cocinaBien(remy,_).
tutor(linguini,Tutor):-
    trabaja(linguini,Lugar),
    vive(Tutor,Lugar).
tutor(skinner,amelie).
/*
Saber si alguien es chef de un restó. 
Los chefs son, de los que trabajan en el restó, 
aquellos que cocinan bien todos los platos del menú 
ó entre todos los platos que sabe cocinar suma una experiencia de al menos 20.
*/
esChef(Cocinero,Restaurante):-
    trabaja(Cocinero,Restaurante),
    forall(estaEnMenu(Plato,Restaurante),cocinaBien(Cocinero,Plato)).
esChef(Cocinero,Restaurante):-
    trabaja(Cocinero,Restaurante),
    findall(Experiencia,cocina(Cocinero,_,Experiencia),ListaExperiencia),
    sum_list(ListaExperiencia, ExperienciaTotal),
    ExperienciaTotal >= 20.
    
/*
    Deducir cuál es la persona encargada de cocinar un plato en un restaurante, 
    que es quien más experiencia tiene preparándolo en ese lugar.
    Nota: si sos la única persona que cocina el plato, sos el encargado,
    dado que tenés más experiencia cocinando el plato que las demás personas.
*/
encargadoCocinar(Plato,Restaurante,Cocinero):-
    expCocinando(Cocinero,Restaurante,Plato,ExpCocinando),
    forall(expCocinando(Cocinero,Restaurante,Plato,ExpCocinandoAux),ExpCocinando >= ExpCocinandoAux).
expCocinando(Cocinero,Restaurante,Plato,ExpCocinando):-
    trabaja(Cocinero,Restaurante),
    cocina(Cocinero,Plato,ExpCocinando).

/*
    Después de pasar un rato en la cocina, conseguimos un poco más de información sobre los platos!
    También aprendimos la importancia y la información que se necesita para cada tipo de plato.
    En resumen todo plato se cataloga como entrada, principal o postre. 
    De toda entrada se debe aclarar la lista de ingredientes que la componen, 
    de cada plato principal su acompañamiento y el tiempo (en minutos) que demora y 
    de cada postre las calorías que aportan.
    Acá les dejamos la lista de los platos más vendidos con ejemplos:
*/
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

/*
    Si un plato es saludable (si tiene menos de 75 calorías).
    - En las entradas, cada ingrediente suma 15 calorías.
    - Los platos principales suman 5 calorías por cada minuto de cocción. 
    Las guarniciones agregan a la cuenta total: las papas fritas 50 y el puré 20, 
    mientras que la ensalada no aporta calorías.
    - De los postres ya conocemos su cantidad de calorías.
*/
esSaludable(Plato):-
    cantidadCalorias(Plato,Calorias),
    Calorias < 75.
cantidadCalorias(Plato,Calorias):-
    plato(Plato,entrada(Ingredientes)),
    length(Ingredientes,CantidadIngredientes),
    Calorias is CantidadIngredientes * 15.
cantidadCalorias(Plato,Calorias):-
    plato(Plato,principal(Guarnicion,MinutoCoccion)),
    plusGuarnicion(Guarnicion,Plus),
    Calorias is Plus + (MinutoCoccion * 5).
cantidadCalorias(Plato,Calorias):-
    plato(Plato,postre(Calorias)).
plusGuarnicion(papas_fritas,50).
plusGuarnicion(pure,20).
plusGuarnicion(ensalada,0).

/*
Un restaurante recibe mayor reputación si un crítico le escribe una reseña positiva. 
Queremos saber si algún crítico le hizo una reseña positiva a algún restaurante.
Cada crítico maneja su propio criterio, 
pero todos están de acuerdo en lo mismo: el lugar no debe tener ratas viviendo en él.
- Anton Ego espera, además, que en el lugar sean especialistas preparando ratatouille. 
    Un restaurante es especialista en aquellos platos que todos sus chefs saben cocinar bien.
- Cormillot requiere que todos los platos que saben cocinar los empleados del restaurante 
    sean saludables.
- Martiniano es jerarquista, así que requiere que exista sólo un chef en el restaurante.
- Gordon Ramsey no le da una crítica positiva a ningún restaurante.
*/
tieneRatas(Restaurante):-
    vive(_,Restaurante).
reviewPositiva(Critico,Restaurante):-
    trabaja(_,Restaurante),
    criteriosCritico(Critico,Restaurante),
    \+ tieneRatas(Restaurante). 
criteriosCritico(ego,Restaurante):-
    restauranteEspecialista(Restaurante,ratatouille).
criteriosCritico(cormillot,Restaurante):-
    forall(estaEnMenu(Plato,Restaurante),esSaludable(Plato)).
criteriosCritico(martiniano,Restaurante):-
    \+ multiplesChefs(Restaurante).
restauranteEspecialista(Restaurante,Plato):-
    forall(esChef(Chef,Restaurante),cocinaBien(Chef,Plato)).
multiplesChefs(Restaurante):-
    esChef(Cocinero1,Restaurante),
    esChef(Cocinero2,Restaurante),
    Cocinero1 \= Cocinero2.
