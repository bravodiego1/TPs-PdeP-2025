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
    noEstaEnDosPrimerosPaquetes(Figurita), 
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
