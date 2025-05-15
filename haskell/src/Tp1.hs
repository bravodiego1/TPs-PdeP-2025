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

data Pista = UnaPista {
    nombre :: String,
    pais :: String,
    precioBaseDeEntrada :: Int,
    curvas :: Auto -> Auto,
    rectas :: Auto -> Auto,
    boxes ::  Auto -> Auto
} 

ferrari :: Auto
ferrari = UnAuto {
    marca = "Ferrari",
    modelo = "F50",
    desgaste = (0,0),
    velocidadMaxima = 65,
    tiempoDeCarrera = 0,
    apodos = ["La nave", "El fierro", "Ferrucho"]
}

lamborghini :: Auto
lamborghini = UnAuto {
    marca = "Lamborghini",
    modelo = "Diablo",
    desgaste = (4, 7),
    velocidadMaxima = 73,
    tiempoDeCarrera = 0,
    apodos = ["Lambo", "La bestia"]
}

fiat :: Auto
fiat = UnAuto {
    marca = "Fiat",
    modelo = "600",
    desgaste = (27, 33),
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
estaEnBuenEstadoUnAuto unAuto = ((/="Peugeot") . marca) unAuto && ((tiempoDeCarrera unAuto >= 100 && chasis unAuto < 40 && ruedas unAuto < 60) || (tiempoDeCarrera unAuto < 100 && chasis unAuto < 20))


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
esUnChiche unAuto = (chasis unAuto < 20 && (esParElPrimerApodoDe . apodos) unAuto) || (chasis unAuto < 50 && (not. esParElPrimerApodoDe . apodos) unAuto)

esParElPrimerApodoDe :: [String] -> Bool
esParElPrimerApodoDe unosApodos = (even . length) unosApodos

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
esUnaJoya unAuto = desgaste unAuto == (0,0) && (length.apodos) unAuto <= 1 

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


--Punto 2g)
riesgoDeUnAuto :: Auto -> Float --analiza el riesgo de un auto.
riesgoDeUnAuto unAuto
  |(not.estaEnBuenEstadoUnAuto) unAuto  = ruedas unAuto * (velocidadMaxima unAuto) * 0.2
  |otherwise = ruedas unAuto * (velocidadMaxima unAuto) * 0.1 

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
curvaPeligrosa unAuto = tramoCurva 60.0 300.0 unAuto
curvaTranca :: Tramo
curvaTranca unAuto = tramoCurva 110.0 550.0 unAuto
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
tramoRectoClassic unAuto = tramoRecto 715.0 unAuto
tramito :: Tramo
tramito unAuto = tramoRecto 260.0 unAuto
{-
CASOS DE PRUEBA 4b:
> transitar tramoRectoClassic ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,7.15), velocidadMaxima = 65.0, tiempoDeCarrera = 11.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar tramito ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,2.6), velocidadMaxima = 65.0, tiempoDeCarrera = 4.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


zigZagLoco :: Tramo
zigZagLoco unAuto = tramoZigzag 5.0 unAuto
casiCurva :: Tramo
casiCurva unAuto = tramoZigzag 1.0 unAuto
{-
CASOS DE PRUEBA 4c:
> transitar zigZagLoco ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (32.5,5.0), velocidadMaxima = 65.0, tiempoDeCarrera = 15.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar casiCurva ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (6.5,5.0), velocidadMaxima = 65.0, tiempoDeCarrera = 3.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


ruloClasico :: Tramo
ruloClasico unAuto = tramoRuloEnElAire 13.0 unAuto
deseoDeMuerte :: Tramo
deseoDeMuerte unAuto = tramoRuloEnElAire 26.0 unAuto
{-
CASOS DE PRUEBA 4d:
>  transitar ruloClasico ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (19.5,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 1.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitar deseoDeMuerte ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (39.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 2.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


tramoCurva :: Float -> Float -> Tramo
tramoCurva unAngulo unaLongitud unAuto = (sumarDesgasteRuedas 3.0 unaLongitud unAngulo . sumarTiempoDeCarrera 1.0 unaLongitud (velocidadMaxima unAuto) 2.0) unAuto
--unAuto {desgaste = (ruedas unAuto + calcularDesgaste (fromIntegral (3)) unaLongitud unAngulo, chasis unAuto), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado (fromIntegral (1)) unaLongitud (velocidadMaxima unAuto) (fromIntegral (2))}

tramoRecto :: Float -> Tramo
tramoRecto unaLongitud unAuto = (actualizarDesgasteChasis (+ calcularDesgaste unaLongitud 1.0 100.0) . sumarTiempoDeCarrera 1.0 unaLongitud (velocidadMaxima unAuto) 1.0) unAuto
--unAuto {desgaste = (ruedas unAuto, chasis unAuto + calcularDesgaste unaLongitud (fromIntegral (1)) (fromIntegral (100))), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado (fromIntegral (1)) unaLongitud (velocidadMaxima unAuto) (fromIntegral (1))}

tramoZigzag :: Float -> Tramo
tramoZigzag cambiosDeDireccion unAuto = (sumarDesgasteRuedas cambiosDeDireccion (velocidadMaxima unAuto) 10.0 . degasteDeChasisIgual5 . sumarTiempoDeCarrera cambiosDeDireccion 3.0 1.0 1.0) unAuto
--unAuto {desgaste = (ruedas unAuto + calcularDesgaste (velocidadMaxima unAuto) cambiosDeDireccion (fromIntegral (10)), 5), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado cambiosDeDireccion (fromIntegral (3)) (fromIntegral (1)) (fromIntegral (1))}

tramoRuloEnElAire :: Float -> Tramo
tramoRuloEnElAire diametroDelRulo unAuto = (sumarDesgasteRuedas diametroDelRulo 1.5 1.0 . sumarTiempoDeCarrera 5.0 diametroDelRulo (velocidadMaxima unAuto) 1.0) unAuto
--unAuto {desgaste = (ruedas unAuto + calcularDesgaste diametroDelRulo 1.5 (fromIntegral (1)), chasis unAuto), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado (fromIntegral (5)) diametroDelRulo (velocidadMaxima unAuto) (fromIntegral (1))} 


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

degasteDeChasisIgual5 :: Auto -> Auto
degasteDeChasisIgual5 unAuto = unAuto{ desgaste = (ruedas unAuto, 5) }


calcularDesgaste :: Float -> Float -> Float -> Float
calcularDesgaste numero1 numero2 numero3 =   numero1 * numero2 / numero3

calcularTiempoAgregado :: Float -> Float -> Float -> Float -> Float
calcularTiempoAgregado numero1 numero2 numero3 numero4 =  numero1 *  numero2 / ( numero3 / numero4 )

-- Punto 5.a)
{- 
nivelDeJoyez :: [Auto] -> Int -- devuelve su nivel de joya.
nivelDeJoyez unosAutos = (sum . map unidadesDeJoyez) unosAutos

unidadesDeJoyez :: Auto -> Int
unidadesDeJoyez unAuto 
  | esUnaJoya unAuto && tiempoDeCarrera unAuto < 50 = 1
  | esUnaJoya unAuto && tiempoDeCarrera unAuto >= 50 = 2
  | otherwise = 0
-}

{- CASOS DE PRUEBA:  
> nivelDeJoyez  [UnAuto {marca = "Peugeot", modelo = "504", desgaste = (0,0), velocidadMaxima = 0, tiempoDeCarrera = 50, apodos = ["El rey del desierto"]}, UnAuto {marca = "Peugeot", modelo = "504", desgaste = (0,0), velocidadMaxima = 40, tiempoDeCarrera = 49, apodos = ["El rey del desierto"]}, UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0), velocidadMaxima = 0, tiempoDeCarrera = 0, apodos = ["La nave", "El fierro", "Ferrucho"]}]
3 verifica -}

--Punto 5b
paraEntendidos :: [Auto] -> Bool
paraEntendidos autos = all estaEnBuenEstadoUnAuto autos && all (tiempoDeCarreraMenorA200) autos
{- 
paraEntendidos autos
  | all estaEnBuenEstadoUnAuto autos && all (tiempoDeCarreraMenorA200) autos = "El grupo es para entendidos"
  | otherwise = "El grupo no es para entendidos"
-}

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
