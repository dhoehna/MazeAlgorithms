{-# LANGUAGE FlexibleContexts #-}
-- ^ need to use MTL style type anotation
{-# LANGUAGE MultiWayIf #-}
-- ^ allows if guard hybrid
{-# LANGUAGE ConstraintKinds #-}
-- ^ allows constraing synonyms

module Main where
import Maze
import Cell
import Control.Monad
import Common
import Control.Lens    ((&), (.~), (%~), ix)
import System.Random

-- getRandomNumber :: IO Int
-- getRandomNumber = randomRIO(0::Int, 1::Int)

-- getRandomNumberFromList :: Int -> Int-> [Int] -> Int
-- getRandomNumberFromList row column randomNumbers = randomNumbers !! (column + (maxWidth * row))

-- fillInMaze :: IO Maze
-- fillInMaze = do   
    -- randomNumbers <- Control.Monad.replicateM numberOfCells getRandomNumber
    -- return [makeCellWithNeighbor maxWidth xCoordinate yCoordinate (randomNumbers !! (getRandomNumberFromList yCoordinate xCoordinate randomNumbers)) | 
                                -- xCoordinate <- [0..(maxWidth - 1)],
                                -- yCoordinate <- [0..(maxHeigth - 1)]]

--applyDirection maze cellAndDirection@(cell, North) = maze & (ix index) .~ cell {hasNorthNeighbor = True} -- . (ix neighborIndex %~ neighborCell {hasSouthNeighbor = true}))
--applyDirection maze cellAndDirection@(cell, East) = maze & (ix index) .~ cell {hasEastNeighbor = True} -- . (ix neighborIndex %~ neighborCell {hasWestNeighbor = true})

-- applyDirection :: Maze -> (Cell, Direction) -> Maze
-- applyDirection maze cellAndDirection@(cell, direction)
 -- | direction == North = maze & (ix index) .~ cell {hasNorthNeighbor = True} . (ix neighborIndex) .~ neighborCell {hasSouthNeighbor = True}
 -- | direction == East = maze & (ix index) .~ cell {hasEastNeighbor = True} . (ix neighborIndex) .~ neighborCell {hasWestNeighbor = True}
 -- where
    -- index = convertPointToIndex (row cell, column cell)
    
-- applyBiDirection :: Maze -> (Cell, Direction) -> Maze
-- applyBiDirection maze cellAndDirection@(cell, direction)
 -- | direction == North = maze & (ix neighborIndex) .~ neighborCell {hasSouthNeighbor = True}
 -- | direction == East = maze & (ix neighborIndex) .~ neighborCell {hasWestNeighbor = True}
 -- where
    -- neighborCell = getNeighborCellFromCell maze cell (snd cellAndDirection)
    -- neighborIndex = getNeighborIndexFromCell cell (snd cellAndDirection)
    
getNeighborCellFromCell :: Maze -> Cell -> Direction -> Cell
getNeighborCellFromCell maze cell direction@North = maze !! convertPointToIndex ((row cell - maxWidth), column cell)
getNeighborCellFromCell maze cell direction@South = maze !! convertPointToIndex (row cell + maxWidth, column cell)
getNeighborCellFromCell maze cell direction@East = maze !! convertPointToIndex (row cell, (column cell + 1))
getNeighborCellFromCell maze cell direction@West = maze !! convertPointToIndex (row cell, (column cell - 1))

getNeighborIndexFromCell :: Cell -> Direction -> Index
getNeighborIndexFromCell cell direction@North = convertPointToIndex (row cell - maxWidth, column cell)
getNeighborIndexFromCell cell direction@South = convertPointToIndex (row cell + maxWidth, column cell)
getNeighborIndexFromCell cell direction@East = convertPointToIndex (row cell, (column cell + 1))
getNeighborIndexFromCell cell direction@West = convertPointToIndex (row cell, (column cell - 1))
    
getCellFromIndex :: Maze -> Index -> Cell
getCellFromIndex maze index = maze !! index
    
getRandomNeighbor :: Cell -> IO Cell
getRandomNeighbor cell = do 
    randomNumber <- randomRIO(0, 1)
    if (randomNumber == (0::Int))
        then pure cell {hasNorthNeighbor = True}
    else pure cell {hasEastNeighbor = True}
    
addDirection :: Cell -> IO Cell
addDirection cell
    | row cell == 0 && column cell /= maxWidth - 1 = pure cell {hasEastNeighbor = True}
    | row cell /= 0 && column cell == maxWidth - 1 = pure cell {hasNorthNeighbor = True}
    | row cell == 0 && column cell == maxWidth - 1 = pure cell
    | otherwise = getRandomNeighbor cell
    
assignByWestNeighbor :: Maze -> Cell -> Cell
assignByWestNeighbor maze cell =
    if isValidIndex ( getNeighborIndexFromCell cell West) && doesWestNeighborHaveEastNeighbor 
        then cell {hasEastNeighbor = True}
    else 
        cell
    where doesWestNeighborHaveEastNeighbor = hasEastNeighbor $ getNeighborCellFromCell maze cell West
        

assignBySouthNeighbor :: Maze -> Cell -> Cell
assignBySouthNeighbor maze cell =
    if isValidIndex ( getNeighborIndexFromCell cell South) && doesSouthNeighborHaveNorthNeighbor
        then cell {hasSouthNeighbor = True}
    else 
        cell
    where doesSouthNeighborHaveNorthNeighbor = hasNorthNeighbor $ getNeighborCellFromCell maze cell South

addBiDirectionalNeighbor :: Maze -> Cell -> Cell
addBiDirectionalNeighbor maze cell = do
    let modifiedCellByWest = assignByWestNeighbor maze cell
    let modifiedCellBySouth = assignBySouthNeighbor maze modifiedCellByWest

main :: IO ()
main = do
    let indexList = [0..(numberOfCells - 1)] --Make a list o fints
    let cells = map makeCellWithIndex indexList --Make a list of default cells (Maze)    
    cellsWithNeighbor <- mapM addDirection cells
    let completeCells = map (addBiDirectionalNeighbor cellsWithNeighbor) cellsWithNeighbor
    
    print completeCells