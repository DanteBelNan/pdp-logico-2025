% Se tiene la siguiente base de conocimiento de gustos cinéfilos
genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

/*
Definir los siguientes predicados completamente inversibles:
1) soloLeGustaPeliculaDeGenero/2, relaciona una persona con su género si todas las películas 
que les gusta pertenecen a dicho género.
*/
persona(Persona):-
    gusta(Persona,_).
soloLeGustanPeliculasDeGenero(Persona,Genero):-
    persona(Persona),genero(_,Genero),
    forall(gusta(Persona,Pelicula),genero(Pelicula,Genero)).

%2) peliculasQueLeGustaPorGenero/3 relaciona una persona, con un género y una lista de películas 
%que les gusta de dicho género
peliculasQueLeGustanPorGenero(Persona,Genero,Peliculas):-
    persona(Persona),
    genero(_,Genero),
    findall(Pelicula,leGustaPorGenero(Persona,Genero,Pelicula),Peliculas).
leGustaPorGenero(Persona,Genero,Pelicula):-
    gusta(Persona,Pelicula),
    genero(Pelicula,Genero).