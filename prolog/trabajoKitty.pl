% BASE DE CONOCIMIENTO:

% consiguio(Quien, NumeroPaquete, ListaDeFiguritasDelPaquete).
consiguio(andy,1,[2,4]).
consiguio(andy,2,[7,6]).
consiguio(andy,3,[8,1,3,5]).
consiguio(flor,1,[5]).
consiguio(flor,2,[5]).
consiguio(bobby,1,[3,5]).
consiguio(bobby,2,[7]).
consiguio(lala,1,[3,7,1]).
consiguio(toto,1,[1]).

% canje(PersonaQueDa, PersonaQueRecibe, listaDeFiguritasRecibidas).
canje(flor,andy,[1]).
canje(andy,flor,[4,7]).
canje(bobby,flor,[2]).
canje(flor,bobby,[1,4,6]).
canje(lala, pablito, [1]).
canje(pablito,lala,[5]).
canje(toto,pablito,[2]).
canje(pablito, toto, [6]).

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
