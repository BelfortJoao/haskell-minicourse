module Main where

import           Data.Matrix (Matrix, fromLists, prettyMatrix, toLists)
import qualified Data.Matrix as M 
import           Data.Maybe (fromMaybe)
import           Graphics.Gloss

lerInicial :: String -> IO (Matrix Bool)
lerInicial fp = do
    texto <- readFile fp 
    let linhas = lines texto
    let booleanos = map (map (== '#')) linhas
    return(fromLists booleanos)

atualizar :: Matrix Bool -> Matrix Bool
atualizar m = M.mapPos (atualizarCelula m) m

atualizarCelula :: Matrix Bool -> (Int, Int) -> Bool -> Bool
atualizarCelula m (i, j) v = (v && (vivos == 2 || vivos == 3)) || vivos == 3
    where
        deslocamentos = [(-1, -1), (-1, 0), (-1, 1),
                         (0, -1),           (0, 1),
                         (1, -1),   (1, 0),  (1, 1)]
        vizinhos = map (\(di,dj) -> M.safeGet (i+di) (j+dj) m) deslocamentos
        vizinhos' = map (fromMaybe False) vizinhos
        vivos = length (filter (\x -> x) vizinhos')

{-
mostrarMatriz :: Matrix Bool -> String
mostrarMatriz m = foldr (\a b -> a ++ "\n" ++ b) "" strings
        where
                linhas = toLists m
                strings = map (map(\v -> if v then '#' else '.')) linhas
-}
 
cellSize :: Int
cellSize = 10
 
toPicture :: Matrix Bool -> Picture
toPicture grid =
    Pictures [
        Color white (rectangleWire w' h'),
        Scale 1 (-1) $
            Translate (-w'/2.0) (-h'/2.0) $
                Pictures (map Pictures (toLists cells))
    ]
    where
        w' = fromIntegral $ M.ncols grid * cellSize
        h' = fromIntegral $ M.nrows grid * cellSize
        cells = M.mapPos toPicture' grid
 
toPicture' :: (Int, Int) -> Bool -> Picture
toPicture' (i,j) v =
    Translate x y $
        Color (makeColor 1 1 1 (if v then 1 else 0)) $
            rectangleSolid (fromIntegral cellSize) (fromIntegral cellSize)
    where
        x = (fromIntegral j - 0.5) * fromIntegral cellSize
        y = (fromIntegral i - 0.5) * fromIntegral cellSize

main :: IO ()
main = do
    let fp = "teste.txt"
    m <- lerInicial fp
    run m
    where 
        run m = do
            let w = M.ncols m
            let h = M.nrows m 
            let tamanho = ((w+1) *cellSize, (h+1)*cellSize)
            let evolve _ _ = atualizar
            simulate 
                (InWindow "Jogo da Vida" tamanho (0,0)) black 60 m toPicture evolve
