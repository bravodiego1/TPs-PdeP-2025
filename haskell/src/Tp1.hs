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
    apodos = ["La Bocha", "La Bolita", "Fitito"]
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

estadoDeSaludDelAuto :: Auto -> String -- devuelve el estado de salud de un auto dependiendo de su tiempo de carrera y su chasis.
estadoDeSaludDelAuto unAuto
  | esPeugeot unAuto = "No esta en buen estado"
  | tiempoDeCarrera unAuto < 100 && chasis unAuto < 20 = "Esta en buen estado"
  | tiempoDeCarrera unAuto >= 100 && chasis unAuto < 40 && ruedas unAuto < 60 = "Esta en buen estado"
  | otherwise = "No esta en buen estado"

esPeugeot :: Auto -> Bool
esPeugeot unAuto = ((=="Peugeot"). marca) unAuto

{- CASOS DE PRUEBA: 
> estadoDeSaludDelAuto (UnAuto "Peugeot" "504" (0,0) 40 0 ["El rey del desierto"])
"No esta en buen estado."
> estadoDeSaludDelAuto (UnAuto "Lamborghini" "Diablo" (0,7) 73 99 ["Lambo", "La bestia"])
"Esta en buen estado"
> estadoDeSaludDelAuto (UnAuto "Fiat" "600" (0,33) 44 99 ["La Bocha", "La Bolita", "Fitito"])
"No esta en buen estado"
> estadoDeSaludDelAuto (UnAuto "Ferrari" "F50" (50,30) 65 130 ["La nave", "El fierro", "Ferrucho"])
"Esta en buen estado"
> estadoDeSaludDelAuto (UnAuto "Ferrari" "F50" (50, 45) 65 15 ["La nave", "El fierro", "Ferrucho"])
"No esta en buen estado"
> estadoDeSaludDelAuto (UnAuto "Ferrari" "F50" (70,30) 65 150 ["La nave", "El fierro", "Ferrucho"])
"No esta en buen estado"
-}

-- Punto 2.b)

noDaMas :: Auto -> String -- dependiendo de su apodo, su chasis y sus ruedas, aclara si da o no da para mas.
noDaMas unAuto
  | (comienzaCon "La" . apodos) unAuto && chasis unAuto > 80 = "No da mas"
  | ruedas unAuto > 80 = "No da mas"
  | otherwise = "Da para mas" 

comienzaCon :: String -> [String] -> Bool
comienzaCon unArticulo apodos = ((==unArticulo) . take 2 . head) apodos

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

esUnChiche :: Auto -> String --dependiendo su chasis y su apodo, analiza si es un chiche o no.
esUnChiche unAuto
  | chasis unAuto < 20 && (esPar . apodos) unAuto = "Es un chiche"
  | chasis unAuto < 50 && (not . esPar . apodos) unAuto = "Es un chiche"
  | otherwise = "No es un chiche"

esPar :: [String] -> Bool
esPar unosApodos = (even . length) unosApodos

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
esUnaJoya :: Auto -> String -- dependiendo su desgaste y la cantidad de apodos, analiza si es una joya o no.
esUnaJoya unAuto 
    |desgaste unAuto == (0,0) && (length.apodos) unAuto <= 1 = "Es una joya"
    |otherwise = "No es una joya"

{-
CASOS DE PRUEBA:
esUnaJoya peugeot
  > "Es una Joya"
esUnaJoya ferrari
  > "No es una joya"
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
capacidadSuperCalifragilisticaespialidosa unAuto = (length.recibirPrimerApodo) unAuto

recibirPrimerApodo :: Auto -> String
recibirPrimerApodo unAuto = (head.apodos) unAuto

{-
Caso de Prueba:
capacidadSuperCalifragilisticaespialidosa ferrari
> 7
-}

--Punto 2g)
{-
-}

riesgoDeUnAuto :: Auto -> Float --analiza el riesgo de un auto.
riesgoDeUnAuto unAuto
  |estadoDeSaludDelAuto unAuto == "No esta en buen estado" = ruedas unAuto * (velocidadMaxima unAuto) * 0.2
  |otherwise = ruedas unAuto * (velocidadMaxima unAuto) * 0.1 

{-
Casos de Prueba
riesgoDeUnAuto lamborghini
> 29.2
riesgoDeUnAuto Fiat
237.6
-}

-- Punto 3a)

porcentaje :: Float -> Float -> Float
porcentaje valor porciento = valor * porciento / 100

sumaOrestaDePorcentaje :: String -> Float -> Float -> Float
sumaOrestaDePorcentaje "RESTA" valor porciento = valor - (porcentaje valor) porciento
sumaOrestaDePorcentaje "SUMA" valor porciento = valor + (porcentaje valor) porciento
sumaOrestaDePorcentaje _ valor porciento = valor 

repararAuto :: Auto -> Auto -- Reparar el auto deja en 0 el desgaste y reduce un 85% el chasis.
repararAuto auto = auto {desgaste = (0, sumaOrestaDePorcentaje "RESTA" ((snd.desgaste) auto) 85)} 

{- 
Casos de prueba:
> repararAuto fiat 
UnAuto {marca = "Fiat", modelo = "600", desgaste = (0, 4.950001), velocidadMaxima = 44.0, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
> repararAuto ferrari 
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 0, apodos = ["La nave","El fierro","Ferrucho"]}
-}

-- Punto 3b)

aplicarPenalidad :: Auto -> Float -> Auto -- aplica penalidad a un auto, incrementando un tiempo de penalizacion al tiempo de carrera.
aplicarPenalidad auto tiempoPenalizacion = auto {tiempoDeCarrera = tiempoDeCarrera auto + tiempoPenalizacion}

{-
Casos de prueba: 
> aplicarPenalidad ferrari 20
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 30, apodos = ["La nave","El fierro","Ferrucho"]}
> aplicarPenalidad ferrari 0 
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 10, apodos = ["La nave","El fierro","Ferrucho"]}
-}

-- Punto 3c)

autoConNitro :: Auto -> Auto --aumenta un 20% su velocidad maxima.
autoConNitro auto = auto {velocidadMaxima = sumaOrestaDePorcentaje "SUMA" (velocidadMaxima auto) 20}

{- 
Casos de prueba:
> autoConNitro fiat
UnAuto {marca = "Fiat", modelo = "600", desgaste = (27,33.0), velocidadMaxima = 52.8, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
> autoConNitro fiat
UnAuto {marca = "Fiat", modelo = "600", desgaste = (27,33.0), velocidadMaxima = 0.0, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
-}

-- Punto 3d) 
bautizarUnAuto:: String -> Auto -> Auto --agrega apodo al auto.
bautizarUnAuto unApodo unAuto = unAuto {apodos = apodos unAuto ++ [unApodo]} 

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

transitarUnTramo :: String -> Auto -> Auto --REALIZO DISTINTOS TRAMOS.
transitarUnTramo "CurvaPeligrosa" unAuto = curvaPeligrosa unAuto
transitarUnTramo "CurvaTranca" unAuto = curvaTranca unAuto

transitarUnTramo "TramoRectoClassic" unAuto = tramoRectoClassic unAuto
transitarUnTramo "Tramito" unAuto = tramito unAuto 

transitarUnTramo "ZigZagLoco" unAuto = zigZagLoco unAuto 
transitarUnTramo "casiCurva" unAuto = casiCurva unAuto

transitarUnTramo "RuloClasico" unAuto = ruloClasico unAuto
transitarUnTramo "deseoDeMuerte" unAuto = deseoDeMuerte unAuto

transitarUnTramo _ unAuto = unAuto

curvaPeligrosa :: Auto -> Auto
curvaPeligrosa unAuto = tramoCurva (fromIntegral (60)) (fromIntegral(300)) unAuto
curvaTranca :: Auto -> Auto
curvaTranca unAuto = tramoCurva (fromIntegral (110)) (fromIntegral (550)) unAuto
{-
CASO DE PRUEBAS 4a:
> transitarUnTramo "CurvaPeligrosa" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (15.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 9.230769, apodos = ["La nave","El fierro","Ferrucho"]}

> transitarUnTramo "CurvaPeligrosa" peugeot
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (15.0,0.0), velocidadMaxima = 40.0, tiempoDeCarrera = 15.0, apodos = ["El rey del desierto"]}   

> transitarUnTramo "CurvaTranca" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (15.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 16.923077, apodos = ["La nave","El fierro","Ferrucho"]}

> transitarUnTramo "CurvaTranca" peugeot
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (15.0,0.0), velocidadMaxima = 40.0, tiempoDeCarrera = 27.5, apodos = ["El rey del desierto"]}
-}


tramoRectoClassic :: Auto -> Auto
tramoRectoClassic unAuto = tramoRecto (fromIntegral (715)) unAuto
tramito :: Auto -> Auto
tramito unAuto = tramoRecto (fromIntegral (260)) unAuto
{-
CASOS DE PRUEBA 4b:
> transitarUnTramo "TramoRectoClassic" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,7.15), velocidadMaxima = 65.0, tiempoDeCarrera = 11.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitarUnTramo "Tramito" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0.0,2.6), velocidadMaxima = 65.0, tiempoDeCarrera = 4.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


zigZagLoco :: Auto -> Auto
zigZagLoco unAuto = tramoZigzag (fromIntegral (5)) unAuto
casiCurva :: Auto -> Auto
casiCurva unAuto = tramoZigzag (fromIntegral (1)) unAuto
{-
CASOS DE PRUEBA 4c:
> transitarUnTramo "ZigZagLoco" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (32.5,5.0), velocidadMaxima = 65.0, tiempoDeCarrera = 15.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitarUnTramo "casiCurva" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (6.5,5.0), velocidadMaxima = 65.0, tiempoDeCarrera = 3.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


ruloClasico :: Auto -> Auto
ruloClasico unAuto = tramoRuloEnElAire (fromIntegral (13)) unAuto
deseoDeMuerte :: Auto -> Auto
deseoDeMuerte unAuto = tramoRuloEnElAire (fromIntegral (26)) unAuto
{-
CASOS DE PRUEBA 4d:
> transitarUnTramo "RuloClasico" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (19.5,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 1.0, apodos = ["La nave","El fierro","Ferrucho"]}

> transitarUnTramo "deseoDeMuerte" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (39.0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 2.0, apodos = ["La nave","El fierro","Ferrucho"]}
-}


tramoCurva :: Float -> Float -> Auto -> Auto
tramoCurva unAngulo unaLongitud unAuto = unAuto {desgaste = (fst (desgaste unAuto) + calcularDesgaste (fromIntegral (3)) unaLongitud unAngulo, snd(desgaste unAuto)), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado (fromIntegral (1)) unaLongitud (velocidadMaxima unAuto) (fromIntegral (2))}

tramoRecto :: Float -> Auto -> Auto
tramoRecto unaLongitud unAuto = unAuto {desgaste = (fst (desgaste unAuto), snd(desgaste unAuto) + calcularDesgaste unaLongitud (fromIntegral (1)) (fromIntegral (100))), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado (fromIntegral (1)) unaLongitud (velocidadMaxima unAuto) (fromIntegral (1))}

tramoZigzag :: Float -> Auto -> Auto
tramoZigzag cambiosDeDireccion unAuto = unAuto {desgaste = (fst (desgaste unAuto) + calcularDesgaste (velocidadMaxima unAuto) cambiosDeDireccion (fromIntegral (10)), 5), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado cambiosDeDireccion (fromIntegral (3)) (fromIntegral (1)) (fromIntegral (1))}

tramoRuloEnElAire :: Float -> Auto -> Auto
tramoRuloEnElAire diametroDelRulo unAuto = unAuto {desgaste = (fst (desgaste unAuto) + calcularDesgaste diametroDelRulo 1.5 (fromIntegral (1)), snd(desgaste unAuto)), tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado (fromIntegral (5)) diametroDelRulo (velocidadMaxima unAuto) (fromIntegral (1))}

calcularDesgaste :: Fractional a => a -> a -> a -> a
calcularDesgaste numero1 numero2 numero3 =  numero1 * numero2 / numero3

calcularTiempoAgregado :: Fractional a => a -> a -> a -> a -> a
calcularTiempoAgregado numero1 numero2 numero3 numero4 = numero1 * numero2 / ( numero3 / numero4 )

-- Punto 5.a)

nivelDeJoyez :: [Auto] -> Int -- devuelve su nivel de joya.
nivelDeJoyez unosAutos = (sum . map unidadesDeJoyez) unosAutos

unidadesDeJoyez :: Auto -> Int
unidadesDeJoyez unAuto 
  | determinarUnidadesDeJoyezDe unAuto && tiempoDeCarrera unAuto < 50 = 1
  | determinarUnidadesDeJoyezDe unAuto && tiempoDeCarrera unAuto >= 50 = 2
  | otherwise = 0

determinarUnidadesDeJoyezDe :: Auto -> Bool
determinarUnidadesDeJoyezDe unAuto = ((=="Es una joya") . esUnaJoya) unAuto

{- CASOS DE PRUEBA:  
> nivelDeJoyez  [UnAuto {marca = "Peugeot", modelo = "504", desgaste = (0,0), velocidadMaxima = 0, tiempoDeCarrera = 50, apodos = ["El rey del desierto"]}, UnAuto {marca = "Peugeot", modelo = "504", desgaste = (0,0), velocidadMaxima = 40, tiempoDeCarrera = 49, apodos = ["El rey del desierto"]}, UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0), velocidadMaxima = 0, tiempoDeCarrera = 0, apodos = ["La nave", "El fierro", "Ferrucho"]}]
3 verifica -}

--Punto 5b
paraEntendidos :: [Auto] -> String
paraEntendidos autos
  | all tienenBuenEstadoDeSalud autos && all (tiempoDeCarreraMenorA200) autos = "El grupo es para entendidos"
  | otherwise = "El grupo no es para entendidos"

tienenBuenEstadoDeSalud :: Auto -> Bool
tienenBuenEstadoDeSalud unAuto = ((== "Esta en buen estado").estadoDeSaludDelAuto) unAuto 

tiempoDeCarreraMenorA200 :: Auto -> Bool
tiempoDeCarreraMenorA200 unAuto = (<=200) (tiempoDeCarrera unAuto)

{-
CASOS DE PRUEBA 5b:
> paraEntendidos [(UnAuto "Ferrari" "F50" (0,0) 65 200 ["La nave", "El fierro", "Ferrucho"]),(UnAuto "Ferrari" "F50" (0,0) 65 201 ["La nave", "El fierro", "Ferrucho"])]
"El grupo no es para entendidos"

> paraEntendidos [(UnAuto "Ferrari" "F50" (0,0) 65 200 ["La nave", "El fierro", "Ferrucho"]), peugeot]
"El grupo no es para entendidos"

> paraEntendidos [(UnAuto "Ferrari" "F50" (0,0) 65 200 ["La nave", "El fierro", "Ferrucho"]),(UnAuto "Lamborghini" "Diablo" (4,7) 73 200 ["Lambo", "La bestia"])]
"El grupo es para entendidos"
-}
