module Maze where
import Cell

type Maze = [IO Cell]

maxWidth :: Int
maxWidth = 5

maxHeigth :: Int
maxHeigth = 5

numberOfCells :: Int
numberOfCells = maxWidth * maxHeigth

canCellMakeNorthNeighbor :: Int -> Bool
canCellMakeNorthNeighbor xPositionOfCell = xPositionOfCell > 0

canCellMakeEastNeighbor :: Int -> Bool
canCellMakeEastNeighbor yPositionOfCell = yPositionOfCell < 4