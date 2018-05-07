{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified GHC.Exts as E
import qualified Data.Map.Unboxed.Unboxed as M
import qualified Data.Map.Unboxed.Lifted as ML

value :: M.Map Int Int
value = E.fromList [(6,100),(2,9)]

valueX :: ML.Map Int Int
valueX = E.fromList [(7,100),(18,11)]

main :: IO ()
main = do
  putStrLn "Hello, world!"
  print value
  print valueX
