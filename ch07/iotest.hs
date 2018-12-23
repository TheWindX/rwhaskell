{-# LANGUAGE ScopedTypeVariables #-}

import Data.List
import Data.Char
import System.IO
import System.Directory
import Control.Monad
import Control.Exception (IOException, bracket, handle)
import System.Environment

allFiles :: String -> IO ([FilePath], [String])
allFiles dirName = do
    fnames <- getDirectoryContents dirName
    let fnames1 = filter (\fn -> not (elem fn  [".", ".."])) fnames
    dirNames <- filterM doesDirectoryExist fnames1
    fileNames <- filterM doesFileExist fnames1
    return (fileNames, dirNames)


fileInfos = do
    args <- getArgs
    let dir = args !! 0
    handle (\(e::IOException)->putStrLn $ show e) (do
        (fs, dirs) <- allFiles dir
        putStrLn ("files: " ++ (show fs) ++ ", directories: " ++ (show dirs)))
    

transformFile fi fo = do
    existF1 <- doesFileExist fi
    if not existF1 then fail ("not found "++fi)
    else do
        bracket (openFile fo WriteMode) hClose (\ho -> do
            bracket (openFile fi ReadMode) hClose (\hi -> 
                let copyLine::IO () = do
                    isEof <- hIsEOF hi
                    if isEof then return ()
                    else do
                        l <- hGetLine hi                
                        let l1 = map toUpper l
                        hPutStrLn ho l1
                        copyLine
                in copyLine)
            )
        
        
    
