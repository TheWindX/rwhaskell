{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment

main = do
    args <- getArgs
    let len = length args
    if len < 1 then error ("args is less than 1")
    else do
        let fname = args !! 0
        content <- readFile fname
        let (cs::String) = foldl (\t a -> t++a) [] (words content)
        let strLen = show.length $ cs
        putStrLn ("the characters of "++fname++" is "++strLen)

