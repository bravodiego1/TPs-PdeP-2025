module Tp1 where
import Text.Show.Functions()

--Punto 1

type Ruedas = Int
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

-- Punto 2.a)

estadoDeSaludDelAuto :: Auto -> String 
estadoDeSaludDelAuto (UnAuto marca _ (ruedas,chasis) _ tiempoDeCarrera _)
  | (=="Peugeot") marca  = "No esta en buen estado"
  | tiempoDeCarrera > 100 && chasis < 40 && ruedas < 60 = "Esta en buen estado"
  | tiempoDeCarrera < 100 && chasis < 20 = "Esta en buen estado"
  | otherwise = "No esta en buen estado"

{- 
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

-- Usando pattern matching
noDaMas :: Auto -> String
noDaMas (UnAuto _ _ (ruedas,chasis) _ _ (apodo: _ ))
  | comienzaCon "La" apodo && chasis > 80 = "No da mas"
  | ruedas > 80 = "No da mas"
  | otherwise = "Da para mas" 

comienzaCon :: String -> String -> Bool
comienzaCon unArticulo unApodo = ((==unArticulo) . take 2 ) unApodo

{- > noDaMas' (UnAuto "Ferrari" "F50" (20,90) 65 130 ["La nave", "El fierro", "Ferrucho"])
No da más. verifica

> noDaMas' (UnAuto "Ferrari" "F50" (50,30) 0 20 ["La nave", "El fierro", "Ferrucho"])
Da para más  verifica 

> noDaMas' (UnAuto "Lamborghini" "Diablo" (90,20) 73 99 ["Lambo", "La bestia"])
No da más.  verifica 

> noDaMas' (UnAuto "Lamborghini" "Diablo" (0,0) 73 99 ["Lambo", "La bestia"])
Da para más verifica -}


-- Punto 2.c)

-- con pattern matching
esUnChiche :: Auto -> String
esUnChiche (UnAuto _  _ (ruedas,chasis) _ _ unosApodos)
  | chasis < 20 && esPar unosApodos = "Es un chiche"
  | chasis < 50 && (not . esPar) unosApodos = "Es un chiche"
  | otherwise = "No es un chiche"

esPar :: [String] -> Bool
esPar unosApodos = (even . length) unosApodos

{- 
> esUnChiche' (UnAuto "Lamborghini" "Diablo" (0,7) 73 99 ["Lambo", "La bestia"])
Es un chiche verifica

> esUnChiche' (UnAuto "Lamborghini" "Diablo" (90,20) 73 99 ["Lambo", "La bestia"])
No es un chiche  no verifica

> esUnChiche' (UnAuto "Ferrari" "F50" (20,90) 65 130 ["La nave", "El fierro", "Ferrucho"])
No es un chiche.  verifica 

> esUnChiche' (UnAuto "Ferrari" "F50" (0,0) 65 130 ["La nave", "El fierro", "Ferrucho"])
Es un chiche  verifica 
-}

-- Punto 3a)

porcentaje :: Float -> Float -> Float
porcentaje valor porciento = valor * porciento / 100

sumaOrestaDePorcentaje :: String -> Float -> Float -> Float
sumaOrestaDePorcentaje "RESTA" valor porciento = valor - (porcentaje valor) porciento
sumaOrestaDePorcentaje "SUMA" valor porciento = valor + (porcentaje valor) porciento
sumaOrestaDePorcentaje _ valor porciento = valor 

repararAuto :: Auto -> Auto
repararAuto auto = auto {desgaste = (0, sumaOrestaDePorcentaje "RESTA" ((snd.desgaste) auto) 85)} 

{- 
Casos de prueba:
> repararAuto fiat 
UnAuto {marca = "Fiat", modelo = "600", desgaste = (0, 4.950001), velocidadMaxima = 44.0, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
> repararAuto ferrari 
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 0, apodos = ["La nave","El fierro","Ferrucho"]}
-}

-- Punto 3b)

aplicarPenalidad :: Auto -> Float -> Auto
aplicarPenalidad auto tiempoPenalizacion = auto {tiempoDeCarrera = tiempoDeCarrera auto + tiempoPenalizacion}

{-
Casos de prueba: 
> aplicarPenalidad ferrari 20
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 30, apodos = ["La nave","El fierro","Ferrucho"]}
> aplicarPenalidad ferrari 0 
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (0,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 10, apodos = ["La nave","El fierro","Ferrucho"]}
-}

-- Punto 3c)

autoConNitro :: Auto -> Auto
autoConNitro auto = auto {velocidadMaxima = sumaOrestaDePorcentaje "SUMA" (velocidadMaxima auto) 20}

{- 
Casos de prueba:
> autoConNitro fiat
UnAuto {marca = "Fiat", modelo = "600", desgaste = (27,33.0), velocidadMaxima = 52.8, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
> autoConNitro fiat
UnAuto {marca = "Fiat", modelo = "600", desgaste = (27,33.0), velocidadMaxima = 0.0, tiempoDeCarrera = 0, apodos = ["La Bocha","La Bolita","Fitito"]}
-}

-- Punto 3d) 
bautizarUnAuto:: String -> Auto -> Auto
bautizarUnAuto unApodo unAuto = unAuto {apodos = apodos unAuto ++ [unApodo]} 

{- 
Casos de prueba: 
> bautizarUnAuto "El diablo" lamborghini
UnAuto {marca = "Lamborghini", modelo = "Diablo", desgaste = (4,7.0), velocidadMaxima = 73.0, tiempoDeCarrera = 0, apodos = ["Lambo","La bestia","El diablo"]}
> bautizarUnAuto "El diablo" lamborghini
UnAuto {marca = "Lamborghini", modelo = "Diablo", desgaste = (4,7.0), velocidadMaxima = 73.0, tiempoDeCarrera = 0, apodos = ["El diablo"]}
-}

-- Punto 3e)
llevarUnAutoAUnDesarmadero :: Auto -> String -> String -> Auto
llevarUnAutoAUnDesarmadero unAuto nuevaMarca nuevoModelo = unAuto {marca = nuevaMarca, modelo = nuevoModelo, apodos = ["Nunca Taxi"]}

{- 
Casos de prueba: 
> llevarUnAutoAUnDesarmadero fiat "Tesla" "X"
UnAuto {marca = "Tesla", modelo = "X", desgaste = (27,33.0), velocidadMaxima = 44.0, tiempoDeCarrera = 0, apodos = ["Nunca Taxi"]}
-}

-- Punto 4a)
transitarUnaCurva :: String -> Auto -> Auto
transitarUnaCurva "Peligrosa" unAuto = curvaPeligrosa unAuto
transitarUnaCurva "Tranca" unAuto = curvaTranca unAuto

curvaPeligrosa :: Auto -> Auto
curvaPeligrosa unAuto = aplicarCurva 60 300 unAuto

curvaTranca :: Auto -> Auto
curvaTranca unAuto = aplicarCurva 110 550 unAuto 

aplicarCurva :: Int -> Int -> Auto -> Auto
aplicarCurva angulo longitud unAuto = actualizarDesgaste angulo longitud . actualizarTiempo longitud $ unAuto

actualizarDesgaste :: Int -> Int -> Auto -> Auto
actualizarDesgaste unAngulo unaLongitud unAuto = unAuto {desgaste = (fst (desgaste unAuto) + calcularDesgaste unAngulo unaLongitud, snd (desgaste unAuto))}

calcularDesgaste :: Int -> Int -> Int
calcularDesgaste angulo longitud = floor (3 * fromIntegral longitud / fromIntegral angulo)

actualizarTiempo :: Int -> Auto -> Auto
actualizarTiempo unaLongitud unAuto = unAuto {tiempoDeCarrera = tiempoDeCarrera unAuto + calcularTiempoAgregado unaLongitud (velocidadMaxima unAuto)}

calcularTiempoAgregado :: Int -> Float -> Float
calcularTiempoAgregado longitud velocidadMax = fromIntegral longitud / (velocidadMax / 2)

{- 
Casos de prueba: 
> transitarUnaCurva "Peligrosa" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (15,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 9.230769, 
apodos = ["La nave","El fierro","Ferrucho"]}
> transitarUnaCurva "Peligrosa" peugeot
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (15,0.0), velocidadMaxima = 40.0, tiempoDeCarrera = 15.0, apodos = ["El rey del desierto"]}
> transitarUnaCurva "Tranca" ferrari
UnAuto {marca = "Ferrari", modelo = "F50", desgaste = (15,0.0), velocidadMaxima = 65.0, tiempoDeCarrera = 16.923077, apodos = ["La nave","El fierro","Ferrucho"]}
> transitarUnaCurva "Tranca" peugeot
UnAuto {marca = "Peugeot", modelo = "504", desgaste = (15,0.0), velocidadMaxima = 40.0, tiempoDeCarrera = 27.5, apodos = ["El rey del desierto"]}
-}
