{-# LANGUAGE ScopedTypeVariables #-}

import System.Environment

main = do
    args <- getArgs
    if length args < 1 
    then error ("args is less than 1"++(show.length $ args))
    else do
        let fname::String = args !! 0
        content <- readFile fname
        let wc = show.length.words $ content
        putStrLn $ ("words count of "++fname++" is "++wc)
