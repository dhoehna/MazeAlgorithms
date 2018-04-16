module Main where

import Lib


--grid
--cell
--neighbors NORTH, SOUTH, EAST, WEST

data HasNorthNeighbor = HasNorthNeighbor
data HasSouthNeighbor = HasSouthNeighbor
data HasEastNeighbor = HasEastNeighbor
data HasWestNeighbor = HasWestNeighbor

--Cell :: HasNorthNeighbor -> HasSouthNeighbor -> HasEastNeighbor -> HasWestNeighbor -> Cell
data Cell = Cell HasNorthNeighbor HasSouthNeighbor HasEastNeighbor HasWestNeighbor


main :: IO ()
main = someFunc





