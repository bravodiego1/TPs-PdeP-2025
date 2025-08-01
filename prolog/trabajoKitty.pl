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
canje(flor,andy,[1]).
canje(andy,flor,[4,7]).
canje(bobby,flor,[2]).
canje(flor,bobby,[1,4,6]).
canje(lala, pablito, [1]).
canje(pablito,lala,[5]).
canje(toto,pablito,[2]).
canje(pablito, toto, [6]).

% Punto 1 

tieneFiguritas(Persona,ListaFiguritas):-
    paquete(Persona,_,ListaFiguritas). 
    
    tieneFiguritas(Persona,ListaFiguritas):-
        canje(_,Persona,ListaFiguritas).
    
% Punto 2
    
tieneRepetida(Persona, Figurita):-
    paquete(Persona, _, _),
    findall(OtraFigurita, tieneFiguritas(Persona, OtraFigurita), Lista), 
    flatten(Lista, ListaAplanada),
    select(Figurita, ListaAplanada, Resto),
    member(Figurita, Resto). 
        
 %Punto 3
        
rara(Figurita):-
    figurita(Figurita, _),
    noEstaEnDosPrimerosPaquetes(Figurita). 
    
rara(Figurita):-
    figurita(Figurita, _),
    consiguioMenosDeLaMitad(Figurita), 
    noEstaRepetida(Figurita). 
        
noEstaEnDosPrimerosPaquetes(Figurita):-
    not(estaEnPaquete(1, Figurita)), 
    not(estaEnPaquete(2, Figurita)). 
    
    estaEnPaquete(NumeroPaquete, Figurita):-
        paquete(_,NumeroPaquete,ListaFiguritas), 
        member(Figurita, ListaFiguritas). 

        noEstaRepetida(Figurita):-
            not(tieneRepetida(_, Figurita)). 
            
            consiguioMenosDeLaMitad(Figurita):-
                findall(OtraPersona, distinct(OtraPersona, tieneFiguritas(OtraPersona, _)), Lista), 
                length(Lista, Total), 
                findall(Persona, distinct(Persona, tieneFiguritas(Persona, Figurita)), OtraLista), 
                length(OtraLista, Cantidad), 
                Cantidad < Total / 2. 
            
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

% Punto 4 %
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
    Nivel = (5 *Popularidad).

nivelDeAtractivo(Numero,0):-
    figurita(Numero,rompecabezas(Parte)),
    findall(Numero,figurita(Numero,rompecabezas(Parte)),ListaDeNumeros),
    length(ListaDeNumeros,Cantidad),
    Cantidad > 2.

nivelDeAtractivo(Numero,2):-
    figurita(Numero,rompecabezas(Parte)),
    findall(Numero,figurita(Numero,rompecabezas(Parte)),ListaDeNumeros),
    length(ListaDeNumeros,Cantidad),
    Cantidad =< 2.

nivelDeAtractivo(Numero,Nivel):-
    figurita(Numero,basica(ListaDePersonajes)),
    findall(Popularidad,(popularidad(Personaje,Popularidad)),ListaDePopularidad),
    sum_list(ListaDePopularidad,Cantidad),
    Nivel = Cantidad.
    