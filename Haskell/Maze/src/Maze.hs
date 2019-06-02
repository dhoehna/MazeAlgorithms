module Maze where
import Cell
import Data.Sequence
import Common

type Maze = [Cell]

maxWidth :: Int
maxWidth = 5

maxHeigth :: Int
maxHeigth = 5

numberOfCells :: Int
numberOfCells = maxWidth * maxHeigth

canCellMakeNorthNeighbor :: Int -> Bool
canCellMakeNorthNeighbor xPositionOfCell = xPositionOfCell > 0

canCellMakeEastNeighbor :: Int -> Bool
canCellMakeEastNeighbor yPositionOfCell = yPositionOfCell < (maxWidth - 1)

addBreadcrumbToCell :: Seq (Maybe Direction) -> Maybe Direction -> Int -> Int -> Seq (Maybe Direction)
addBreadcrumbToCell oldDirections (Just East) _ _ = oldDirections |> (Just West)
addBreadcrumbToCell oldDirections (Just North) maxWidth oldIndex = Data.Sequence.update (oldIndex - maxWidth) (Just South) oldDirections

-- getNeighborWithDirection :: Maze -> Cell -> Maybe Direction
-- getNeighborWithDirection maze cell@(Cell True _ _ _ _ _ _ _) = grabNeighborFromDirection maze cell North
-- getNeighborWithDirection maze cell@(Cell _ _ True _ _ _ _ _) = grabNeighborFromDirection maze cell East
-- getNeighborWithDirection maze cell@(Cell False _ False _ _ _ _ _) = Cell False False False False (maxWidth - 1) 0 False 0

-- grabNeighborFromDirection :: Maze -> Cell -> Direction -> Cell
--Get north neighbor and give it a south neighbor
-- grabNeighborFromDirection _ _ North = Cell False False False False 0 0 False 0
--Get East neighbor and give it a west neighbor
-- grabNeighborFromDirection _ _ East = Cell False False False False 0 0 False 0

--getCellFromRowAndColumn :: Maze -> int -> int -> Direction -> Cell
--getCellFromRowAndColumn _ row column North = 
--getIndexFromRowAndColumn :: int -> int -> int
--getIndexFromRowAndColumn row column = 
    
    