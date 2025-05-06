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

{- Saber si un auto está en buen estado, lo que podemos determinar de la siguiente manera:
Los Peugeot no están jamás en buen estado (basado en algún hecho real). 
Si es de otra marca, 
Si tiene una cantidad de segundos en carrera menor a 100, se determina en buen estado cuando el desgaste de chasis es menor a 20. 
En caso contrario, cuando el desgaste del chasis es menor a 40 y el de las ruedas es menor a 60. -}

estadoDeSaludDelAuto :: Auto -> String 
estadoDeSaludDelAuto unAuto 
  | ((=="Peugeot") . marca) unAuto = "No esta en buen estado"
  | tiempoDeCarrera unAuto >= 100 && ((<40) . snd . desgaste) unAuto && ((<60) . fst . desgaste) unAuto = "Esta en buen estado"
  | tiempoDeCarrera unAuto < 100 &&  ((<20) . snd . desgaste) unAuto = "Esta en buen estado"
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
