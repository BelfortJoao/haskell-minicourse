import Data.List (partition)

--Comentario é com dois hífens seguidos

hello :: IO ()
hello = putStrLn "Hello World!"

-- Nome da função junto dos parâmetros
dobro :: Num a => a -> a
dobro x = x*2

{-
bhaskara a b c = 
    if delta < 0
        then [] 
        else if delta == 0 then [x'] else [x', x'']
-}


-- Delta
delta :: Floating a => a -> a -> a -> a
delta a b c = b**2 - 4*a*c

-- Bhaskara
bhaskara :: (Ord a, Floating a) => a -> a -> a -> [a]
bhaskara a b c
    | d < 0 = []
    | d == 0 = [x']
    | otherwise = [x', x'']
    where
        d = delta a b c
        x' = (-b + sqrt d) / (2*a)
        x'' = (-b - sqrt d) / (2*a)

-- Fib Recursivo
fib  :: Int ->  Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib(n-2)

-- Fib Iterativo
fib2 :: Int -> Int
fib2 0 = 0
fib2 1 = 1
fib2 n = fib' 0 1 2
    where
        fib' n2 n1 i =
            if i == n
                then n2 + n1 
                else fib' n1 (n2+n1) (i+1)

-- Lista Infinita
fibSeq :: [Integer]
fibSeq = 0 : 1 : zipWith (+) fibSeq (tail fibSeq)

-- Lista 

-- Percorreer a lista
-- f :: [a] -> [a] --Qualquer tipo
-- f (h:t) = h : f t -- Head -> Tail

f :: [a] -> Int
f [] = 0
f (h:t) = 1 + f t

{- Teste
f[1,2,3] = 1 + f[2,3]
         = 1 + 1 f [3]
         = 1 + 1 + 1 + f[]
         = 1 + 1 + 1
-}

-- Tamanho da lista
len :: [a] -> Int
len []  = 0
len (h:t) = 1 + len t

-- Somar a lista
sum' :: [Int] -> Int
sum' [] = 0
sum' (h:t) = h + sum' t

{-
Função de ordem superior 
usada para dobrar (ou reduzir) uma lista da direita para a esquerda 
(ou seja, começando do final da lista) 
-}

-- foldr (*) 1 [1,3,6] 
-- foldr (+) 0 [1,3,6] 

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f z [] = z
foldr' f z (h:t) = f h (foldr' f z t)

{-
foldr (+) 0 [1,2,3] = (+) 1 (foldr (+) 0 [2,3])
-}

{-
foldr' (+) 0 [1,2,3] = (+) 1 (foldr' (+) 0 [2,3])
                     = (+) 1 ((+) 2 (foldr' (+) 0 [3]))
                     = (+) 1 ((+)) 2 ((+) 3 (foldr' (+) 0 [])))
                     = (+) 1 ((+) 2 ((+) 3 0))
                     = (+) 1 5
                     = 6
-}                 

-- Filtrar filter' (\x -> x `mod` 2 == 1) [0 .. 25]
filter' :: (a -> Bool) -> [a] -> [a]
filter' f [] = []
filter' f (h:t) = if f h 
    then h : filter' f t
    else filter' f t

-- Map map' (1/) [1..10]
map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (h:t) = f h : map' f t



-- QuickSort quicksort [5,7,9,1,2]
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (pivot:t) = quicksort lt ++ [pivot] ++ quicksort gt

    where lt = filter (<pivot) t
          gt = filter (>= pivot) t
    
    -- where (lt,gt) = partition (<pivot) t