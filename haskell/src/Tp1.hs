module Tp1 where
import Text.Show.Functions()

--Punto 1

type Ruedas = Int
type Chasis = Int

data Auto = UnAuto {
    marca :: String,
    modelo :: String,
    desgaste :: (Ruedas, Chasis),
    velocidadMaxima :: Int,
    tiempoDeCarrera :: Int,
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
