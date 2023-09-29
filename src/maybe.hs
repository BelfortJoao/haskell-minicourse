import Data.List (lookup)
import Data.Maybe (fromMaybe)

-- Indice indiceLetra 'B'
-- Tuplas: [('A', 1), ('B', 2), ('C', 3), ...]
indiceLetra :: Char -> Int
indiceLetra c = fromMaybe 0 m
    {-
    case m of 
        Nothing -> 0
        Just i -> i
    -}
    where m = lookup c (zip ['A'..'Z'][1..])

indiceLetra2 :: Char -> Maybe Int
indiceLetra2 c = lookup c (zip ['A'..'Z'][1..])

-- lookupBy  --> Busca um elemento em uma lista com base em uma função de teste
-- lookupBy (\p -> head p == 'a') ["livro", "asas", "casa"]
lookupBy :: (a -> Bool) -> [a] -> Maybe a
lookupBy f [] = Nothing
lookupBy f (h:t) =
    if f h
        then Just h
        else lookupBy f t