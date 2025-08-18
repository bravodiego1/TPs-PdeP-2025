% BASE DE CONOCIMIENTO:

% paquete(Quien, NumeroPaquete, ListaDeFiguritasDelPaquete).
paquete(andy,1,[2,4]).
paquete(andy,2,[7,6]).
paquete(andy,3,[8,1,3,5]).
paquete(flor,1,[5]).
paquete(flor,2,[5]).
paquete(bobby,1,[3,5]).
paquete(bobby,2,[7]).
paquete(lala,1,[3,7,1]).
paquete(toto,1,[1]).

% canje(PersonaQueDa, PersonaQueRecibe, listaDeFiguritasRecibidas).
/* canje(flor,andy,[1]).
canje(andy,flor,[4,7]).
canje(bobby,flor,[2]).
canje(flor,bobby,[1,4,6]).
canje(lala, pablito, [1]).
canje(pablito,lala,[5]).
canje(toto,pablito,[2]).
canje(pablito, toto, [6]). */

% canje(PersonaQueDa, FiguritasQueDa, PersonaQueRecibe, FiguritasQueRecibe)
canje(andy,[4,7],flor,[1]).
canje(flor, [1,4,6],bobby, [2]).
canje(pablito, [5],lala, [1]).
canje(pablito,[6],toto,[2]).

% Punto 1 

tieneFigurita(Persona, Figurita):-
    tieneFiguritas(Persona, ListaFiguritas), 
    member(Figurita, ListaFiguritas). 

tieneFiguritas(Persona, ListaFiguritas):-
    paquete(Persona, _, ListaFiguritas). 

tieneFiguritas(Persona,ListaFiguritas):-
    canje(Persona, _, _, ListaFiguritas).

tieneFiguritas(Persona, ListaFiguritas):-
    canje(_, ListaFiguritas, Persona, _).

/* versión anterior:
tieneFiguritas(Persona,ListaFiguritas):-
    paquete(Persona,_,ListaFiguritas). 

tieneFiguritas(Persona,ListaFiguritas):-
    canje(Persona,_,_,ListaFiguritas).

tieneFiguritas(Persona,ListaFiguritas):-
    canje(_,ListaFiguritas,Persona,_).
*/ 

% Punto 2

tieneRepetida(Persona, Figurita):-
    figuritasJuntas(Persona, Figuritas),
    select(Figurita, Figuritas, Resto),
    member(Figurita, Resto).

figuritasJuntas(Persona,Figuritas):-
    tieneFigurita(Persona, _), 
    findall(Figurita, tieneFigurita(Persona, Figurita), Figuritas). 

/* versión anterior: 
tieneRepetida(Persona, Figurita):-
    figuritasJuntas(Persona,Figuritas),
    select(Figurita,Figuritas, Resto),
    member(Figurita, Resto). 

figuritasJuntas(Persona,Figuritas):-    
    tieneFiguritas(Persona,_), 
    findall(OtraFigurita, tieneFiguritas(Persona, OtraFigurita), Lista), 
    flatten(Lista, Figuritas).
*/

% Punto 3  

rara(Figurita):-
    figurita(Figurita, _),
    noEstaEnDosPrimerosPaquetes(Figurita). 
    
rara(Figurita):-
    figurita(Figurita, _),
    consiguioMenosDeLaMitad(Figurita), 
    not(tieneRepetida(_, Figurita)).
        
noEstaEnDosPrimerosPaquetes(Figurita):-
    not(estaEnPaquete(1, Figurita)), 
    not(estaEnPaquete(2, Figurita)). 
    
estaEnPaquete(NumeroPaquete, Figurita):-
    paquete(_, NumeroPaquete, ListaFiguritas), 
    member(Figurita, ListaFiguritas). 

consiguioMenosDeLaMitad(Figurita):-
    cantidadTotalDePersonas(TotalDePersonas), 
    cantidadDePersonasQueTienen(Figurita, CantidadQueTienenLaFigurita), 
    CantidadQueTienenLaFigurita < TotalDePersonas / 2. 

cantidadTotalDePersonas(TotalDePersonas):-
    findall(Persona, distinct(Persona, tieneFigurita(Persona, _)), ListaPersonasTotal), 
    length(ListaPersonasTotal, TotalDePersonas). 

cantidadDePersonasQueTienen(Figurita, CantidadQueTienenLaFigurita):-
    findall(Persona, distinct(Persona, tieneFigurita(Persona, Figurita)), PersonasQueLaTienen), 
    length(PersonasQueLaTienen, CantidadQueTienenLaFigurita). 

/* versión anterior: 
consiguioMenosDeLaMitad(Figurita):-
    findall(OtraPersona, distinct(OtraPersona, tieneFiguritas(OtraPersona, _)), Lista), 
    length(Lista, Total), 
    findall(Persona, distinct(Persona, tieneFiguritas(Persona, Figurita)), OtraLista), 
    length(OtraLista, Cantidad), 
    Cantidad < Total / 2. 
*/  

% Casos de prueba: 
/* ¿Cuáles figuritas tiene Bobby? La 1, 3, 4, 5, 6 y 7.
?- tieneFiguritas(bobby, Figurita).
    Figurita = [3, 5] ;
    Figurita = [7] ;
    Figurita = [1, 4, 6].

¿Cuáles figuritas tiene Lala? La 1, 3, 5 y 7.
?- tieneFiguritas(lala, Figurita). 
Figurita = [3, 7, 1] ;
Figurita = [5].

¿Juanchi tiene figuritas? No.
?- tieneFiguritas(juanchi, _).
false.

¿Cuáles figuritas tiene repetidas Flor? La 5.
?- tieneRepetida(flor, Figurita).
Figurita = 5 .

¿Andy tiene figuritas repetidas? Sí.
?- tieneRepetida(andy, _).
true .

¿La figurita 8 es rara? Sí.
?- rara(8).
true .

¿La figurita 1 es rara? No.
?- rara(1).
false.
*/

% Punto 4
% figurita(Numero, basica([Personaje])).
% figurita(Numero, brillante(Personaje)).
% figurita(Numero, rompecabezas(ImagenQueForman)).

figurita(1, basica([kitty, keroppi])).
figurita(2, brillante(kitty)).
figurita(3, brillante(myMelody)). 
figurita(4, basica([])).
figurita(5, rompecabezas(restaurante)).
figurita(6, rompecabezas(restaurante)).
figurita(7, rompecabezas(restaurante)).
figurita(8, basica([kitty,cinnamoroll,badtzMaru,keroppi,pompompurin,gudetama,myMelody,littleTwinStars,kuromi])).
figurita(9, brillante(badtzMaru)).

% PUNTO 5 %

%popularidad(Personaje,Popularidad).

popularidad(kitty,5).
popularidad(cinnamoroll,4).
popularidad(badtzMaru,2).
popularidad(keroppi,3).
popularidad(pompompurin,4).
popularidad(gudetama,1).
popularidad(myMelody,3).
popularidad(littleTwinStars,2).
popularidad(kuromi,5).

esValiosa(Numero):-
    figurita(Numero,_),
    rara(Numero).

esValiosa(Numero):-
    figurita(Numero,_),
    nivelDeAtractivo(Numero,Nivel),
    Nivel > 7.

nivelDeAtractivo(Numero,Nivel):-
    figurita(Numero,brillante(Personaje)),
    popularidad(Personaje,Popularidad),
    Nivel is (5 *Popularidad). 

nivelDeAtractivo(Numero,NivelDeAtractivo):-
    figurita(Numero,rompecabezas(Parte)),
    findall(Numero,figurita(Numero,rompecabezas(Parte)),ListaDeNumeros),
    length(ListaDeNumeros,Cantidad),
    nivelDeAtractivoDeRompecabezasSegunCantidad(Cantidad,NivelDeAtractivo).

nivelDeAtractivo(Numero,Nivel):-
    figurita(Numero,basica(ListaDePersonajes)),
    findall(Popularidad,(member(Personaje,ListaDePersonajes),popularidad(Personaje,Popularidad)),ListaDePopularidad),
    sum_list(ListaDePopularidad,Nivel).

nivelDeAtractivoDeRompecabezasSegunCantidad(Cantidad,0):-
    Cantidad>2.

nivelDeAtractivoDeRompecabezasSegunCantidad(Cantidad,2):-
    Cantidad=<2.

% Punto 6 %

imagenMasAtractiva(Persona,Imagen):-
    figuritasJuntas(Persona,ListaDeFiguritas),
    member(Figurita,ListaDeFiguritas),
    nivelDeAtractivo(Figurita,Nivel),
    forall((member(OtraFigurita,ListaDeFiguritas), OtraFigurita \= Figurita),(nivelDeAtractivo(OtraFigurita,OtroNivel), OtroNivel < Nivel)),
    figurita(Figurita,Imagen).

% Punto 7 %

tieneFiguritaRaraNueva(FigusRecibidas, FigusActuales):-
    member(Figurita, FigusRecibidas),
    not(member(Figurita, FigusActuales)),
    rara(Figurita).

% Si hay figurita rara nueva.
queTanInteresanteEs(Persona, FigusRecibidas, NivelFinal):-
    figuritasJuntas(Persona, FigusActuales),
    findall(Atractivo,(member(Figurita, FigusRecibidas), not(member(Figurita, FigusActuales)),nivelDeAtractivo(Figurita, Atractivo)),AtractivosAusentes),
    sumlist(AtractivosAusentes, NivelBase),
    tieneFiguritaRaraNueva(FigusRecibidas, FigusActuales),
    NivelFinal is NivelBase + 20.

% Si no hay figurita rara nueva.
queTanInteresanteEs(Persona, FigusRecibidas, NivelFinal):-
    figuritasJuntas(Persona, FigusActuales),
    findall(Atractivo,(member(Figurita, FigusRecibidas),not(member(Figurita, FigusActuales)),nivelDeAtractivo(Figurita, Atractivo)),AtractivosAusentes),
    sumlist(AtractivosAusentes, NivelFinal),
    not(tieneFiguritaRaraNueva(FigusRecibidas, FigusActuales)).

% Punto 8 %

esValidoPaquete(ListaDeFiguritas):-
    forall(member(Figurita,ListaDeFiguritas),figurita(Figurita, _)).

esValidoCanje(QuienDa, FigusQueDa, QuienRecibe, FigusQueRecibe):-
    figuritasJuntas(QuienDa, FigusDeQuienDa),
    figuritasJuntas(QuienRecibe, FigusDeQuienRecibe),
    forall(member(Figurita, FigusQueDa), member(Figurita, FigusDeQuienDa)),
    forall(member(Figurita, FigusQueRecibe), member(Figurita, FigusDeQuienRecibe)).

esValido(canje(QuienDa, FigusDa, QuienRecibe, FigusRecibe)) :-
    esValidoCanje(QuienDa, FigusDa, QuienRecibe, FigusRecibe).
esValido(paquete(Figuritas)) :-
    esValidoPaquete(Figuritas).

/* Punto 9 */

haceNegocio(Persona, FiguritasQueDa, Otro, FiguritasQueRecibe):-
    canje(Persona,FiguritasQueDa,Otro,FiguritasQueRecibe),
    tieneValiosa(FiguritasQueRecibe),
    not(tieneValiosa(FiguritasQueDa)).

tieneValiosa(Figuritas):-
    member(Figurita,Figuritas),
    esValiosa(Figurita).

/*
 ?- haceNegocio(pablito,[5],lala,[1]).
true.

?- haceNegocio(toto,[2],pablito,[6]).
false. */

/* Punto 10 */

necesitaConUrgencia(Persona,Figurita):-
    leFaltaFigurita(Figurita,FiguritasQueTiene,Persona),
    necesitaFigurita(Figurita,FiguritasQueTiene).

necesitaFigurita(Figurita,FiguritasQueTiene):-
    findall(Fig,figurita(Fig,_),TodasFiguritas),
    forall((member(Figurin, TodasFiguritas), Figurin \= Figurita), member(Figurin,FiguritasQueTiene)).

necesitaFigurita(Figurita, FiguritasQueTiene) :-
    figurita(Figurita, rompecabezas(Imagen)),
    figurita(OtraFigurita, rompecabezas(Imagen)),
    Figurita \= OtraFigurita,
    member(OtraFigurita, FiguritasQueTiene).

leFaltaFigurita(Figurita,Figuritas,Persona):-
    figuritasJuntas(Persona,Figuritas),
    figurita(Figurita,_),
    not(member(Figurita,Figuritas)).

/* ?- necesitaConUrgencia(andy,9).
true ;

 ?- necesitaConUrgencia(flor,6).
true ; */

% Punto 11
esUnaAmenaza(Persona, Canjes):-
    tieneFiguritas(Persona,_),
    forall(
    (
        member((Persona, FigusQueDa, OtraPersona, FigusQueRecibe), Canjes),
        haceNegocio(Persona, FigusQueDa, OtraPersona, FigusQueRecibe)
    ),
    saleGanando(Persona,FigusQueDa, FigusQueRecibe)).

saleGanando(Persona,FiguritasQueDa, FiguritasQueRecibe):-
    queTanInteresanteEs(Persona, FiguritasQueRecibe, NivelFinal),
    queTanInteresanteEs(Persona, FiguritasQueDa, OtroNivelFinal),
    NivelFinal>OtroNivelFinal.

/*
	Casos de Pruebas Inventados para el Punto 11

	?- esUnaAmenaza(andy, [(andy, [4], flor, [9])]).
	true.

Si se agregara la siguiente cláusula canje(andy, [4], flor, [9]). , 
Andy hace negocio porque recibe figurita valiosa y la que da no lo es:
	?- nivelDeAtractivo(9,Nivel).
	Nivel = 10 .
	?- esValiosa(9).
	true .

	?- nivelDeAtractivo(4,Nivel).
	Nivel = 0.
	?- esValiosa(4).
	false.
Y también sale ganando, porque lo que obtuvo es más interesante porque:
	?- queTanInteresanteEs(andy,[9],N).
	N = 30 .
	?- queTanInteresanteEs(andy,[4],N).
	N = 0 
(30>0)

	?- esUnaAmenaza(pablito,[(pablito,[5],lala,[1])]).
	false.
Pablito hace negocio pero no sale ganando porque:
	?- queTanInteresanteEs(pablito,[5],N).
	N = 2 .
	?- queTanInteresanteEs(pablito,[1],N).
	N = 0 
(0>2 no es cierto)

*/

% Punto 12
canjesValidosEntre(UnaPersona,OtraPersona,FiguritaUnaPersona,FiguritaOtraPersona):-
    figuritasJuntas(UnaPersona,_),
    tieneRepetida(UnaPersona, FiguritaUnaPersona),

    figuritasJuntas(OtraPersona,OtraLista),
    member(FiguritaOtraPersona,OtraLista),
    estilo(OtraPersona, Estilo),

    aceptaCanje(OtraPersona,Estilo,FiguritaUnaPersona,FiguritaOtraPersona).

aceptaCanje(Persona,clasico,FiguritaARecibir,_):-
    figuritasJuntas(Persona,Figuritas),
    not(member(FiguritaARecibir,Figuritas)).

aceptaCanje(Persona,descartador,_,FiguritaAEntregar):-
    tieneRepetida(Persona, FiguritaAEntregar).

aceptaCanje(_,cazafortunas,FiguritaARecibir,_):-
    esValiosa(FiguritaARecibir).

aceptaCanje(Persona,urgido,FiguritaARecibir,_):-
    necesitaConUrgencia(Persona,FiguritaARecibir).

%estilo(Persona,Estilo).
estilo(andy,descartador).
estilo(flor,descartador).
estilo(bobby,clasico).

/*
	Casos de Pruebas Inventados para el Punto 12

Por el enunciado, se pide que en una persona se verifique que solo la tenga repetida para dar, 
y que con la otra se verifique su estilo de coleccionismo.

	?- canjesValidosEntre(andy,flor,FiguritaUnaPersona,FiguritaOtraPersona). 
	FiguritaUnaPersona = 1,
	FiguritaOtraPersona = 5 .

	?- canjesValidosEntre(flor,andy,FiguritaUnaPersona,FiguritaOtraPersona).
	FiguritaUnaPersona = 5,
	FiguritaOtraPersona = 1 ;

Andy tiene un estilo de coleccionar descartador, es decir, 
solo entregará figuritas que tiene repetidas. 
La 1 la tiene repetida porque la obtuvo en el paquete 3 y se la da Flor en un canje.
Flor también tiene un estilo de coleccionar descartador, 
la figurita 5 la tiene repetida porque le tocó esa en el primer y segundo paquete.


	?- canjesValidosEntre(flor, bobby, F1, F2).
	F1 = 5,
	F2 = 3;
F1 = 5,
F2 = 7 ;
	F1 = 5,
	F2 = 1 ;
F1 = 5,
F2 = 4 ;
	F1 = 5,
	F2 = 6 ;
(todos los casos aparecen repetidos)

Flor tiene un estilo de coleccionar descartador, es decir, 
solo entregará figuritas que tiene repetidas, la 5 en su caso.
Bobby tiene un estilo de coleccionar clásico, 
sólo acepta figuritas que no tenga previamente. 
Por ende, si consideramos que en el paquete 1 solo recibió la 3, 
en lugar de la 3 y la 5, aceptará la 5 de Flor y le dará alguna de las suyas.
*/