module Main where

import Lib
  
newtype HasNorthNeighbor = HasNorthNeighbor Bool
newtype HasSouthNeighbor = HasSouthNeighbor Bool
newtype HasEastNeighbor = HasEastNeighbor Bool
newtype HasWestNeighbor = HasWestNeighbor Bool
  
data Cell = MakeCell
   {
       HasNorthNeighbor
       ,HasSouthNeighbor
       ,HasEastNeighbor
       ,HasWestNeighbor
   }


main :: IO ()
main = someFunc