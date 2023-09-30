import System.Random
import System.IO

-- Função para gerar um caractere aleatório (# ou .)
randomChar :: IO Char
randomChar = do
    rand <- randomRIO (0, 1) :: IO Int
    return $ if rand == 0 then '#' else '.'

-- Função para gerar uma linha aleatória de caracteres
randomLine :: Int -> IO String
randomLine n = sequence $ replicate n randomChar

-- Função para gerar o conteúdo do arquivo
generateContent :: Int -> Int -> IO [String]
generateContent numRows numCols = sequence $ replicate numRows (randomLine numCols)

-- Função principal que escreve o conteúdo em um arquivo chamado "teste.txt"
main :: IO ()
main = do
    let numRows = 100 -- Número de linhas no arquivo
        numCols = 100 -- Número de colunas em cada linha
    content <- generateContent numRows numCols
    writeFile "../jogo-da-vida/teste.txt" (unlines content)
    putStrLn "Arquivo '../../jogo-da-vida/teste.txt' gerado com sucesso!"


