module Tp1 where
import Text.Show.Functions()

--Punto 1

type Ruedas = Float
type Chasis = Float

data Auto = UnAuto {
    marca :: String,
    modelo :: String,
    desgaste :: (Ruedas, Chasis),
    velocidadMaxima :: Float,
    tiempoDeCarrera :: Float,
    apodos :: [String]
} deriving (Show, Eq)

ferrari :: Auto
ferrari = UnAuto {
    marca = "Ferrari",
    modelo = "F50",
    desgaste = (0,10),
    velocidadMaxima = 65,
    tiempoDeCarrera = 0,
    apodos = ["La nave", "El fierro", "Ferrucho"]
}

lamborghini :: Auto
lamborghini = UnAuto {
    marca = "Lamborghini",
    modelo = "Diablo",
    desgaste = (4, 20),
    velocidadMaxima = 73,
    tiempoDeCarrera = 0,
    apodos = ["Lambo", "La bestia"]
}

fiat :: Auto
fiat = UnAuto {
    marca = "Fiat",
    modelo = "600",
    desgaste = (27, 50),
    velocidadMaxima = 44,
    tiempoDeCarrera = 0 ,
    apodos = ["La Bocha", "La bolita", "Fitito"]
}

peugeot :: Auto
peugeot = UnAuto {
    marca = "Peugeot",
    modelo = "504",
    desgaste = (0,0),
    velocidadMaxima = 40,
    tiempoDeCarrera = 0,
    apodos = ["El rey del desierto"]
} 

chasis :: Auto -> Float
chasis unAuto = (snd . desgaste) unAuto

ruedas :: Auto -> Float
ruedas unAuto = (fst . desgaste) unAuto

-- Punto 2.a)

estaEnBuenEstadoUnAuto :: Auto -> Bool
estaEnBuenEstadoUnAuto unAuto = noEsPeugeot unAuto && (esTiempoDeCarreraMayorA100ChasisMenorA40YRuedasMayorA60 unAuto || esTiempoDeCarreraMenorA100YChasisMenorA20 unAuto)

noEsPeugeot :: Auto -> Bool
noEsPeugeot unAuto = ((/="Peugeot") . marca) unAuto

esTiempoDeCarreraMenorA100YChasisMenorA20 :: Auto -> Bool
esTiempoDeCarreraMenorA100YChasisMenorA20 unAuto = ((<100) . tiempoDeCarrera) unAuto && ((<20) . chasis) unAuto

esTiempoDeCarreraMayorA100ChasisMenorA40YRuedasMayorA60 :: Auto -> Bool
esTiempoDeCarreraMayorA100ChasisMenorA40YRuedasMayorA60 unAuto = ((>=100) . tiempoDeCarrera) unAuto && ((<40) . chasis) unAuto && ((<60) . ruedas) unAuto

{- CASOS DE PRUEBA: 
> estaEnBuenEstadoUnAuto (UnAuto "Peugeot" "504" (0,0) 40 0 ["El rey del desierto"])
"No esta en buen estado."
> estaEnBuenEstadoUnAuto (UnAuto "Lamborghini" "Diablo" (0,7) 73 99 ["Lambo", "La bestia"])
"Esta en buen estado"
> estaEnBuenEstadoUnAuto (UnAuto "Fiat" "600" (0,33) 44 99 ["La Bocha", "La Bolita", "Fitito"])
"No esta en buen estado"
> estaEnBuenEstadoUnAuto (UnAuto "Ferrari" "F50" (50,30) 65 130 ["La nave", "El fierro", "Ferrucho"])
"Esta en buen estado"
> estaEnBuenEstadoUnAuto (UnAuto "Ferrari" "F50" (50, 45) 65 15 ["La nave", "El fierro", "Ferrucho"])
"No esta en buen estado"
> estaEnBuenEstadoUnAuto (UnAuto "Ferrari" "F50" (70,30) 65 150 ["La nave", "El fierro", "Ferrucho"])
"No esta en buen estado"
-}

-- Punto 2.b)

noDaMas :: Auto -> Bool
noDaMas unAuto = (comienzaCon "La" (primerApodoDe unAuto) && chasis unAuto > 80 ) || ruedas unAuto > 80

comienzaCon :: String -> String -> Bool
comienzaCon unArticulo unaPalabra = ((==unArticulo) . take (length unArticulo)) unaPalabra

primerApodoDe :: Auto -> String
primerApodoDe unAuto = (head . apodos) unAuto

{- CASOS DE PRUEBA:
> noDaMas (UnAuto "Ferrari" "F50" (20,90) 65 130 ["La nave", "El fierro", "Ferrucho"])
No da más. verifica
> noDaMas (UnAuto "Ferrari" "F50" (50,30) 0 20 ["La nave", "El fierro", "Ferrucho"])
Da para más  verifica 
> noDaMas (UnAuto "Lamborghini" "Diablo" (90,20) 73 99 ["Lambo", "La bestia"])
No da más.  verifica 
> noDaMas (UnAuto "Lamborghini" "Diablo" (0,0) 73 99 ["Lambo", "La bestia"])
Da para más verifica -}

-- Punto 2.c)

esUnChiche :: Auto -> Bool
esUnChiche unAuto = (((<20) . chasis) unAuto &&  esParLaCantidadDeApodosDe unAuto) || (((<50) . chasis) unAuto && (not . esParLaCantidadDeApodosDe) unAuto)

esParLaCantidadDeApodosDe :: Auto -> Bool
esParLaCantidadDeApodosDe unAuto = (even . cantidadDeApodosDe) unAuto

cantidadDeApodosDe :: Auto -> Int
cantidadDeApodosDe unAuto = (length . apodos) unAuto

{- CASOS DE PRUEBA:
> esUnChiche (UnAuto "Lamborghini" "Diablo" (0,7) 73 99 ["Lambo", "La bestia"])
Es un chiche verifica
> esUnChiche (UnAuto "Lamborghini" "Diablo" (90,20) 73 99 ["Lambo", "La bestia"])
No es un chiche verifica
> esUnChiche (UnAuto "Ferrari" "F50" (20,90) 65 130 ["La nave", "El fierro", "Ferrucho"])
No es un chiche.  verifica 
> esUnChiche (UnAuto "Ferrari" "F50" (0,0) 65 130 ["La nave", "El fierro", "Ferrucho"])
Es un chiche  verifica 
-}

-- punto 2d)
esUnaJoya :: Auto -> Bool -- dependiendo su desgaste y la cantidad de apodos, analiza si es una joya o no.
esUnaJoya unAuto = desgaste unAuto == (0,0) && cantidadDeApodosDe unAuto <= 1 

{-
CASOS DE PRUEBA:
esUnaJoya peugeot
  > "True"
esUnaJoya ferrari
  > "False"
-}

--punto 2e)

nivelDeChetez :: Auto -> Int --devuelve el nivel de chetez de un auto, dependiendo de sus apodos y su modelo
nivelDeChetez unAuto = (length.apodos) unAuto * (length.modelo) unAuto * 20

{-
CASOS DE PRUEBA:
nivelDeChetez ferrari
> 180
-}

--Punto 2f)

capacidadSuperCalifragilisticaespialidosa :: Auto -> Int --dependiendo su primer apodo, cuenta la cantidad de letras.
capacidadSuperCalifragilisticaespialidosa unAuto = (length.primerApodoDe) unAuto

{-
Caso de Prueba:
capacidadSuperCalifragilisticaespialidosa ferrari
> 7
-}

calculosParaRiesgo :: Auto -> Float -> Float
calculosParaRiesgo unAuto unNumero = ruedas unAuto * (velocidadMaxima unAuto) * unNumero

--Punto 2g)
riesgoDeUnAuto :: Auto -> Float --analiza el riesgo de un auto.
riesgoDeUnAuto unAuto
  |(not.estaEnBuenEstadoUnAuto) unAuto  = calculosParaRiesgo unAuto 0.2
  |otherwise = calculosParaRiesgo unAuto 0.1 

{-
Casos de Prueba
riesgoDeUnAuto lamborghini
> 29.2
riesgoDeUnAuto Fiat
237.6
-}

-- Punto 3a)

repararAuto :: Auto -> Auto -- Reparar el auto deja en 0 el desgaste y reduce un 85% el chasis.
repararAuto auto = auto {desgaste = (0, (*0.15).chasis $ auto)} 

{- 
Casos de prueba:
> repararAuto fiat 
UnAuto {marca = "Fiat", modelo = "600", desgaste = (0.0, 4.9500003), velocidadMaxima = 44.0, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
> repararAuto ferrari 
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 0, apodos = ["La nave","El fierro","Ferrucho"]}
-}

-- Punto 3b)

aplicarPenalidad :: Auto -> Float -> Auto -- aplica penalidad a un auto, incrementando un tiempo de penalizacion al tiempo de carrera.
aplicarPenalidad auto tiempoPenalizacion = auto {tiempoDeCarrera = tiempoDeCarrera auto + tiempoPenalizacion}

{-
Casos de prueba: 
> aplicarPenalidad ferrari 20
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 30.0, apodos = ["La nave","El fierro","Ferrucho"]}
> aplicarPenalidad ferrari 0 
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 10.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}

-- Punto 3c)

autoConNitro :: Auto -> Auto --aumenta un 20% su velocidad maxima.
autoConNitro auto = auto {velocidadMaxima = (*1.2).velocidadMaxima $ auto}

{- 
Casos de prueba:
> autoConNitro fiat
UnAuto {marca = "Fiat", modelo = "600", desgaste = (27.0,33.0), velocidadMaxima = 52.800003, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
> autoConNitro fiat
UnAuto {marca = "Fiat", modelo = "600", desgaste = (27.0,33.0), velocidadMaxima = 0.0, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
-}

-- Punto 3d) 
bautizarUnAuto:: String -> Auto -> Auto --agrega apodo al auto.
bautizarUnAuto nuevoApodo unAuto = unAuto {apodos = nuevoApodo : apodos unAuto} 

{- 
Casos de prueba: 
> bautizarUnAuto "El diablo" lamborghini
UnAuto {marca = "Lamborghini", modelo = "Diablo", desgaste = (4,7.0), velocidadMaxima = 73.0, tiempoDeCarrera = 0, apodos = ["Lambo","La bestia","El diablo"]}
> bautizarUnAuto "El diablo" lamborghini
UnAuto {marca = "Lamborghini", modelo = "Diablo", desgaste = (4,7.0), velocidadMaxima = 73.0, tiempoDeCarrera = 0, apodos = ["El diablo"]}
-}

-- Punto 3e)
llevarUnAutoAUnDesarmadero :: Auto -> String -> String -> Auto -- cambia su marca y modelo.
llevarUnAutoAUnDesarmadero unAuto nuevaMarca nuevoModelo = unAuto {marca = nuevaMarca, modelo = nuevoModelo, apodos = ["Nunca Taxi"]}

{- 
Casos de prueba: 
> llevarUnAutoAUnDesarmadero fiat "Tesla" "X"
UnAuto {marca = "Tesla", modelo = "X", desgaste = (27,33.0), velocidadMaxima = 44.0, tiempoDeCarrera = 0, apodos = ["Nunca Taxi"]}
-}

--Punto 4
type Tramo = Auto -> Auto
transitar :: Tramo -> Auto -> Auto
transitar unTramo unAuto = unTramo unAuto

curvaPeligrosa :: Tramo
curvaPeligrosa unAuto = tramoCurva 60 300 unAuto
curvaTranca :: Tramo
curvaTranca unAuto = tramoCurva 110 550 unAuto
{-
CASO DE PRUEBAS 4a:
>  transitar curvaPeligrosa ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (15.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 9.230769, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar curvaPeligrosa peugeot 
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (15.0,0.0), velocidadMaxima = 40.0, tiempoDeCarrera = 15.0, apodos = ["El rey del desierto"]}

> transitar curvaTranca ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (15.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 16.923077, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar curvaTranca peugeot 
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (15.0,0.0), velocidadMaxima = 40.0, tiempoDeCarrera = 27.5, apodos = ["El rey del desierto"]}
-}


tramoRectoClassic :: Tramo
tramoRectoClassic unAuto = tramoRecto 715 unAuto
tramito :: Tramo
tramito unAuto = tramoRecto 260 unAuto
{-
CASOS DE PRUEBA 4b:
> transitar tramoRectoClassic ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,7.15), velocidadMaxima = 65.0, tiempoDeCarrera = 11.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar tramito ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,2.6), velocidadMaxima = 65.0, tiempoDeCarrera = 4.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


zigZagLoco :: Tramo
zigZagLoco unAuto = tramoZigzag 5 unAuto
casiCurva :: Tramo
casiCurva unAuto = tramoZigzag 1 unAuto
{-
CASOS DE PRUEBA 4c:
> transitar zigZagLoco ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (32.5,5.0), velocidadMaxima = 65.0, tiempoDeCarrera = 15.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar casiCurva ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (6.5,5.0), velocidadMaxima = 65.0, tiempoDeCarrera = 3.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


ruloClasico :: Tramo
ruloClasico unAuto = tramoRuloEnElAire 13 unAuto
deseoDeMuerte :: Tramo
deseoDeMuerte unAuto = tramoRuloEnElAire 26 unAuto
{-
CASOS DE PRUEBA 4d:
>  transitar ruloClasico ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (19.5,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 1.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar deseoDeMuerte ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (39.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 2.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


tramoCurva :: Float -> Float -> Tramo
tramoCurva unAngulo unaLongitud unAuto = (sumarDesgasteRuedas 3 unaLongitud unAngulo . sumarTiempoDeCarrera 1 unaLongitud (velocidadMaxima unAuto) 2) unAuto

tramoRecto :: Float -> Tramo
tramoRecto unaLongitud unAuto = (actualizarDesgasteChasis (+ calcularDesgaste unaLongitud 1 100) . sumarTiempoDeCarrera 1 unaLongitud (velocidadMaxima unAuto) 1) unAuto

tramoZigzag :: Float -> Tramo
tramoZigzag cambiosDeDireccion unAuto = (sumarDesgasteRuedas cambiosDeDireccion (velocidadMaxima unAuto) 10 . desgasteDeChasisIgual 5 . sumarTiempoDeCarrera cambiosDeDireccion 3 1 1) unAuto
--unAuto {desgaste = (ruedas unAuto + calcularDesgaste (velocidadMaxima unAuto) cambiosDeDireccion (fromIntegral (10)), 5), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado cambiosDeDireccion (fromIntegral (3)) (fromIntegral (1)) (fromIntegral (1))}

tramoRuloEnElAire :: Float -> Tramo
tramoRuloEnElAire diametroDelRulo unAuto = (sumarDesgasteRuedas diametroDelRulo 1.5 1 . sumarTiempoDeCarrera 5 diametroDelRulo (velocidadMaxima unAuto) 1) unAuto


actualizarDesgasteRuedas :: (Float -> Float) -> Auto -> Auto
actualizarDesgasteRuedas unaFuncion unAuto = unAuto{ desgaste = ((unaFuncion.ruedas) unAuto, chasis unAuto)}

actualizarDesgasteChasis :: (Float -> Float) -> Auto -> Auto
actualizarDesgasteChasis unaFuncion unAuto = unAuto{ desgaste = (ruedas unAuto, (unaFuncion.chasis) unAuto) }

actualizarTiempoDeCarrera :: (Float -> Float) -> Auto -> Auto
actualizarTiempoDeCarrera unaFuncion unAuto = unAuto{ tiempoDeCarrera = (unaFuncion.tiempoDeCarrera) unAuto }


sumarDesgasteRuedas :: Float -> Float -> Float -> Auto -> Auto
sumarDesgasteRuedas numero1 numero2 numero3 unAuto = actualizarDesgasteRuedas (+ calcularDesgaste numero1 numero2 numero3) unAuto

sumarTiempoDeCarrera :: Float -> Float -> Float -> Float -> Auto -> Auto
sumarTiempoDeCarrera numero1 numero2 numero3 numero4 unAuto = actualizarTiempoDeCarrera (+ calcularTiempoAgregado numero1 numero2 numero3 numero4) unAuto

desgasteDeChasisIgual :: Float -> Auto -> Auto
desgasteDeChasisIgual unNumero unAuto = unAuto{ desgaste = (ruedas unAuto, unNumero) }


calcularDesgaste :: Float -> Float -> Float -> Float
calcularDesgaste numero1 numero2 numero3 =   numero1 * numero2 / numero3

calcularTiempoAgregado :: Float -> Float -> Float -> Float -> Float
calcularTiempoAgregado numero1 numero2 numero3 numero4 =  numero1 *  numero2 / ( numero3 / numero4 )

-- Punto 5.a)

nivelDeJoyez :: [Auto] -> Int -- devuelve su nivel de joya.
nivelDeJoyez unosAutos = (sum . map unidadesDeJoyez) unosAutos

unidadesDeJoyez :: Auto -> Int
unidadesDeJoyez unAuto 
  | esUnaJoya unAuto && tiempoDeCarrera unAuto < 50 = 1
  | esUnaJoya unAuto && tiempoDeCarrera unAuto >= 50 = 2
  | otherwise = 0


{- CASOS DE PRUEBA:  
> nivelDeJoyez  [UnAuto {marca = "Peugeot", modelo = "504", desgaste = (0,0), velocidadMaxima = 0, tiempoDeCarrera = 50, apodos = ["El rey del desierto"]}, UnAuto {marca = "Peugeot", modelo = "504", desgaste = (0,0), velocidadMaxima = 40, tiempoDeCarrera = 49, apodos = ["El rey del desierto"]}, UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0), velocidadMaxima = 0, tiempoDeCarrera = 0, apodos = ["La nave", "El fierro", "Ferrucho"]}]
3 verifica -}

--Punto 5b
paraEntendidos :: [Auto] -> Bool
paraEntendidos autos = all estaEnBuenEstadoUnAuto autos && all (tiempoDeCarreraMenorA200) autos

tiempoDeCarreraMenorA200 :: Auto -> Bool
tiempoDeCarreraMenorA200 unAuto = ((<=200).tiempoDeCarrera) unAuto

{-
CASOS DE PRUEBA 5b:
> paraEntendidos [(UnAuto "Ferrari" "F50" (0,0) 65 200 ["La nave", "El fierro", "Ferrucho"]),(UnAuto "Ferrari" "F50" (0,0) 65 201 ["La nave", "El fierro", "Ferrucho"])]
False

> paraEntendidos [(UnAuto "Ferrari" "F50" (0,0) 65 200 ["La nave", "El fierro", "Ferrucho"]), peugeot]
False

> paraEntendidos [(UnAuto "Ferrari" "F50" (0,0) 65 200 ["La nave", "El fierro", "Ferrucho"]),(UnAuto "Lamborghini" "Diablo" (4,7) 73 200 ["Lambo", "La bestia"])]
True
-}

--ENTREGA 2

{-
En las carreras, los autos pertenecen a equipos. Cada equipo tiene un nombre, un conjunto de autos y 
un presupuesto disponible. En estos puntos se puede usar recursividad si hace falta.
Modelar un equipo de competición con su nombre, autos y presupuesto. 
Agregar un auto a un equipo, si el equipo tiene suficiente presupuesto. 
Cada auto tiene un costo de inscripción proporcional a su velocidad máxima: $1000 por cada m/s.
-}

--Funciones Auxiliares

modificarAutosDeEquipo :: ([Auto] -> [Auto]) -> Equipo -> Equipo
modificarAutosDeEquipo modificacion unEquipo = unEquipo {autos = (modificacion.autos) unEquipo}

modificarPresupuesto :: (Float -> Float) -> Equipo -> Equipo
modificarPresupuesto modificacion unEquipo = unEquipo {presupuesto = (modificacion.presupuesto) unEquipo}


costoDeFerrarizarUnAuto :: Auto -> Float
costoDeFerrarizarUnAuto unAuto
  |marca unAuto == "Ferrari" = 0
  |otherwise = 3500

esFerrari :: Auto -> Bool
esFerrari unAuto = (== "Ferrari").marca $ unAuto   

costoPorPonerNitro :: Float
costoPorPonerNitro = 100

costoPorRepararAuto :: Float
costoPorRepararAuto = 500

costoNitro :: Auto -> Float
costoNitro unAuto = (velocidadMaxima unAuto) * costoPorPonerNitro

costoReparacionAuto :: Auto -> Float
costoReparacionAuto unAuto = (chasis unAuto) * 0.85 * costoPorRepararAuto

reduccionChasis :: [Auto] -> Float
reduccionChasis unosAutos = (sum.map(chasis) $ unosAutos) * 0.85 

hacerFerrari :: Auto -> Auto
hacerFerrari unAuto = cambiarMarcaFerrariYModeloF50 unAuto

cambiarMarcaFerrariYModeloF50 :: Auto -> Auto
cambiarMarcaFerrariYModeloF50 unAuto = unAuto {marca = "Ferrari", modelo = "F50"}

--EQUIPO

data Equipo = UnEquipo{
    nombreEquipo :: String,
    autos :: [Auto],
    presupuesto :: Float
} deriving (Show,Eq)

--MODELO DE EQUIPO

grupo8 :: Equipo
grupo8 = UnEquipo{
    nombreEquipo = "Grupo 8",
    autos = [ferrari,lamborghini],
    presupuesto = 10000
} 

-- 1A

precioAuto :: Auto -> Float
precioAuto unAuto = velocidadMaxima unAuto * 1000

comprarAuto :: Auto -> Equipo -> Equipo
comprarAuto unAuto unEquipo= (modificarAutosDeEquipo ((:) unAuto) . modificarPresupuesto (subtract (precioAuto unAuto))) unEquipo

agregarAutoAEquipo :: Auto -> Equipo -> Equipo
agregarAutoAEquipo unAuto unEquipo 
  |precioAuto unAuto <= presupuesto unEquipo = comprarAuto unAuto unEquipo
  |otherwise = unEquipo

--Funciones a utilizar en 1B/1C/1D
type Presupuesto = Float

modificarListaDeAutos :: (Auto -> Auto) -> (Auto -> Float)-> [Auto] -> Presupuesto -> [Auto]
modificarListaDeAutos _ _ [] _ = []
modificarListaDeAutos modificacionDeAuto costoAMandar (primerAuto:restoDeLosAutos) presupuesto
  |modificacionDeAuto primerAuto == hacerFerrari primerAuto && esFerrari primerAuto = primerAuto : modificarListaDeAutos (hacerFerrari) costoAMandar restoDeLosAutos presupuesto
  |costoAMandar primerAuto <= presupuesto = modificacionDeAuto primerAuto : modificarListaDeAutos modificacionDeAuto costoAMandar restoDeLosAutos (presupuesto - costoAMandar primerAuto)
  |otherwise = primerAuto : restoDeLosAutos

modificarPresupuestoDeAutos :: (Auto -> Auto) -> (Auto -> Float) -> [Auto] -> Presupuesto -> Presupuesto
modificarPresupuestoDeAutos _ _ [] presupuesto = presupuesto
modificarPresupuestoDeAutos modificacionDeAuto costoAMandar (primerAuto:restoDeLosAutos) presupuesto
  |modificacionDeAuto primerAuto == hacerFerrari primerAuto && esFerrari primerAuto = modificarPresupuestoDeAutos modificacionDeAuto costoAMandar restoDeLosAutos presupuesto
  |costoAMandar primerAuto  <= presupuesto = modificarPresupuestoDeAutos modificacionDeAuto costoAMandar restoDeLosAutos (presupuesto - costoAMandar primerAuto) 
  |otherwise = modificarPresupuestoDeAutos modificacionDeAuto costoAMandar restoDeLosAutos presupuesto

--1B
repararAutosDeEquipo :: Equipo -> Equipo
repararAutosDeEquipo unEquipo = unEquipo{
  autos = modificarListaDeAutos repararAuto costoReparacionAuto (autos unEquipo) (presupuesto unEquipo),
  presupuesto = modificarPresupuestoDeAutos repararAuto costoReparacionAuto (autos unEquipo) (presupuesto unEquipo)
} 

--1C
optimizarAutos :: Equipo -> Equipo
optimizarAutos unEquipo = unEquipo { 
  autos = modificarListaDeAutos autoConNitro costoNitro (autos unEquipo) (presupuesto unEquipo), 
  presupuesto = modificarPresupuestoDeAutos autoConNitro costoNitro (autos unEquipo) (presupuesto unEquipo)
}
--1D
ferrarizar :: Equipo -> Equipo
ferrarizar unEquipo = unEquipo {
  autos = modificarListaDeAutos hacerFerrari costoDeFerrarizarUnAuto (autos unEquipo) (presupuesto unEquipo),
  presupuesto = modificarPresupuestoDeAutos hacerFerrari costoDeFerrarizarUnAuto (autos unEquipo) (presupuesto unEquipo)
}

--Punto 2
costoTotalDeReparacion :: Equipo -> Float
costoTotalDeReparacion unEquipo = (reduccionChasis.autos) unEquipo * 500

{-
CASOS DE PRUEBA 2:

  > costoTotalDeReparacion grupo8 
  12750.0
El grupo 8 está compuesto por
un ferrari de chasis 10 y 
un lamborghini de chasis 20, 
igualemente:
  > costoTotalDeReparacion (UnEquipo "Equipo" [ferrari,lamborghini] 0)
  12750.0

  > costoTotalDeReparacion (UnEquipo "Equipo" [fiat,peugeot] 0)
  21250.0
Para este último caso de prueba del punto 2, se cambió el valor de chasis de los autos.
-}

--Punto 3a)
equipoInfinia :: Equipo
equipoInfinia = UnEquipo {
    nombreEquipo = "Infinia", 
    autos = autosInfinia, 
    presupuesto = 5000
}

autosInfinia :: [Auto]
autosInfinia = map ferrariInfinia [1.0 ..]

ferrariInfinia :: Float -> Auto
ferrariInfinia n = actualizarDesgasteChasis (const 1) . actualizarVelocidadMaxima (*n) $ ferrari 

--Punto 3b) 

--i)
{-Se cuelga, porque los infinitos autos del equipo infinia tienen todos un desgaste de chasis igual a 1 
que no puede reducirse más, con lo cual no hay ningún auto para reparar y por ese motivo 
el presupuesto nunca se agota, que es justamente lo que la función necesita para dejar de iterar-}

--ii) 
{-Se cuelga, porque la funcion de optimizarAutos toma el primer auto de la lista de autos del equipo infinia,
calcula el costo de optimizacion y le da un numero mayor al presupuesto del equipo, asi que no realiza la 
modificacion y el presupuesto no disminuye. Continua el mismo proceso con el auto siguiente, tiene el mismo 
resultado y asi infinitamente, porque ademas de ser infinitos autos, todos los autos infinia son iguales 
por lo cual no pueden ser optimizados-}

--iii)
{-Se cuelga. Como todos los autos del equipo infinia son de marca Ferrari y modelo F50,
la función ferrarizar no podrá convertir a ninguno de ellos, lo que no disminuira el 
presupuesto y provocará que la función siga buscando infinitamente un auto para convertir-}

--iv)
{-Se cuelga, porque la lista debe ser recorrida en su enteridad para realizar tanto el calculo del costo 
de reparacion de cada uno los de los autos del equipo infinia, como la suma de dichos costos. Ya que la 
lista es infinita, la funcion jamas lo conseguira-}

-- Punto 4

boxes :: Tramo -> Tramo
boxes unTramo unAuto 
  | (not . estaEnBuenEstadoUnAuto . unTramo) unAuto = (sumarTiempoDeCarrera 10 1 1 1 . repararAuto . unTramo) unAuto 
  | otherwise = unTramo unAuto 

mojado :: Tramo -> Tramo -- pide ORIGINALMENTE EL TRAMO, es decir si tengo 10 y le sumo 20 con el tramo, tengo 30, y debo obtener ese 20 para dps sumarle 50
mojado unTramo unAuto = (sumarTiempoDeCarrera 0.5 (tiempoDeCarreraOriginalDe unTramo unAuto) 1 1 . unTramo) unAuto

tiempoDeCarreraOriginalDe :: Tramo -> Auto -> Float
tiempoDeCarreraOriginalDe unTramo unAuto = subtract (tiempoDeCarrera unAuto) . tiempoDeCarrera . unTramo $ unAuto

ripio :: Tramo -> Tramo
ripio unTramo unAuto = (sumarTiempoDeCarrera (tiempoDeCarreraOriginalDe unTramo unAuto) 1 1 1 . unTramo . unTramo) unAuto

obstruccion :: Float -> Tramo -> Tramo
obstruccion metros unTramo unAuto = (sumarDesgasteRuedas 2 metros 1 . unTramo) unAuto

turbo :: Tramo -> Tramo
turbo unTramo unAuto = actualizarVelocidadMaxima (const (velocidadMaxima unAuto)) . unTramo . actualizarVelocidadMaxima (*2) $ unAuto

actualizarVelocidadMaxima :: (Float -> Float) -> Auto -> Auto
actualizarVelocidadMaxima unaFuncion unAuto = unAuto {velocidadMaxima = (unaFuncion . velocidadMaxima) unAuto}

--Punto 5

pasarPorTramo2 :: Auto -> Tramo -> Auto
pasarPorTramo2 unAuto unTramo
  | not (noDaMas unAuto) = unTramo unAuto 
  | otherwise = id unAuto

--Punto 6
data Pista = UnaPista {
  nombre :: String,
  pais :: String,
  precioDeEntrada :: Int,
  circuito :: [Tramo]
} deriving Show

vueltaALaManzana :: Pista
vueltaALaManzana = UnaPista {
nombre = "La manzana",
pais = "Italia",
precioDeEntrada = 30,
circuito = circuitoVueltaALaManzana
  --[tramoRecto 130, tramoCurva 90 13, tramoRecto 130, tramoCurva 90 13, tramoRecto 130, tramoCurva 90 13, tramoRecto 130, tramoCurva 90 13]
--aplicación parcial en el llamado de tramos
}

circuitoVueltaALaManzana :: [Tramo]
circuitoVueltaALaManzana = concat.replicate 4 $ [tramoRecto 130, tramoCurva 90 13]

superPista :: Pista
superPista = UnaPista {
  nombre = "Super Pista",
  pais = "Argentina",
  precioDeEntrada = 300,
  circuito = 
    [tramoRectoClassic, curvaTranca, turbo tramito, mojado tramito, tramoRuloEnElAire 10, obstruccion 2 (tramoCurva 80 400), tramoCurva 115 650, tramoRecto 970, curvaPeligrosa, ripio tramito, boxes (tramoRecto 800), obstruccion 5 casiCurva, tramoZigzag 2, mojado.ripio $ deseoDeMuerte, ruloClasico, zigZagLoco]
}

peganLaVuelta2 :: Pista -> [Auto] -> [Auto]
peganLaVuelta2 unaPista unaListaDeAutos = map (pegaLaVuelta (circuito unaPista)) unaListaDeAutos

pegaLaVuelta :: [Tramo] -> Auto -> Auto
pegaLaVuelta unCircuito unAuto = foldl pasarPorTramo2 unAuto unCircuito
--foldr empezaba por el último tramo, y cuando estaba recorriendo "manualmente" lo hacía desde el primero al último, de izquierda a derecha

{-
CASO DE PRUEBA 6:
> peganLaVuelta2 vueltaALaManzana [ferrari,peugeot]
[UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (1.7333333,15.200001), velocidadMaxima = 65.0, tiempoDeCarrera = 9.6, apodos = ["La nave","El fierro","Ferrucho"]},
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (80.3,3.8999999), velocidadMaxima = 40.0, tiempoDeCarrera = 11.7, apodos = ["El rey del desierto"]}]

Se cambió el valor de chasis de ruedas del peugeot para este caso de pueba (de 0 a 79).
-}

-- 7A

data Carrera = UnaCarrera { 
  pista :: Pista,
  numeroDeVueltas :: Int
} deriving Show

-- 7B

tourBuenosAires :: Carrera
tourBuenosAires = UnaCarrera {
   pista = superPista, 
   numeroDeVueltas = 20
}

-- 7C

simularCarrera :: Carrera -> [Auto] -> [[Auto]] -- Retorna una lista de listas de autos, siendo cada lista el resultado parcial de cada vuelta (puede ser que no muestre todas las vueltas si los autos no dan para mas).
simularCarrera (UnaCarrera _ 0) autos = [autos]
simularCarrera (UnaCarrera pista vueltas) [] = []
simularCarrera (UnaCarrera pista vueltas) autos
  | all noDaMas autos = [autos]
  | otherwise = autos : simularCarrera (UnaCarrera pista (vueltas - 1)) (autosTrasUnaVuelta pista autos)

autosTrasUnaVuelta :: Pista -> [Auto] -> [Auto]
autosTrasUnaVuelta pista = map (pegaLaVuelta (circuito pista)) . filter (not . noDaMas)

autoConMenorTiempo :: [Auto] -> Auto
autoConMenorTiempo [auto] = auto
autoConMenorTiempo (auto1:auto2:resto)
  | (> tiempoDeCarrera auto1) . tiempoDeCarrera $ auto2 = autoConMenorTiempo (auto1 : resto)
  | otherwise = autoConMenorTiempo (auto2 : resto)

ganadorDeCarrera :: Carrera -> [Auto] -> Auto
ganadorDeCarrera carrera = autoConMenorTiempo . last . simularCarrera carrera

segundoAuto :: [Auto] -> Auto
segundoAuto (_ : auto2 : _) = auto2
segundoAuto autos = head autos

tiempoTotalSegundoAuto :: Carrera -> [Auto] -> Float
tiempoTotalSegundoAuto carrera autos = tiempoDeCarrera (segundoAuto (last (simularCarrera carrera autos)))

primerAuto :: [Auto] -> Auto
primerAuto (auto : _) = auto

tiempoParcialTras2Vueltas :: Carrera -> [Auto] -> Float
tiempoParcialTras2Vueltas carrera autos = tiempoDeCarrera (primerAuto (simularCarrera carrera autos !! (min 2 (length (simularCarrera carrera autos) - 1))))

cantidadAutosQueTerminaron :: Carrera -> [Auto] -> Int
cantidadAutosQueTerminaron carrera autos = length (filter (not . noDaMas) (last (simularCarrera carrera autos)))
