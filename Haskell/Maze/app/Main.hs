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

-- directions :: Seq (Maybe Direction)
-- directions = Data.Sequence.singleton Nothing

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

applyDirection :: Maze -> (Cell, Direction) -> Maze
applyDirection maze cellAndDirection@(cell, direction)
 | direction == North = maze & (ix index) .~ cell {hasNorthNeighbor = True}
 | direction == East = maze & (ix index) .~ cell {hasEastNeighbor = True}
 | direction == Random = maze & (ix index)
 where
    index = convertPointToIndex (row cell, column cell)
    neigborCell = getNeighborCellFromCell maze cell (snd cellAndDirection)
    neigborIndex = getNeighborIndexFromCell cell (snd cellAndDirection)
    
getNeighborCellFromCell :: Maze -> Cell -> Direction -> Cell
getNeighborCellFromCell maze cell direction@North = maze !! convertPointToIndex ((row cell - maxWidth), column cell)
getNeighborCellFromCell maze cell direction@East = maze !! convertPointToIndex (row cell, (column cell + 1))
 
getNeighborIndexFromCell :: Cell -> Direction -> Index
getNeighborIndexFromCell cell direction@North = convertPointToIndex (row cell - maxWidth, column cell)
getNeighborIndexFromCell cell direction@East = convertPointToIndex (row cell, (column cell + 1))
    
getCellFromIndex :: Maze -> Index -> Cell
getCellFromIndex maze index = maze !! index

main :: IO ()
main = do
    let emptyCells = replicate numberOfCells makeFreshCell
    let directions = replicate numberOfCells getDirection
    let cellsWithDirection = zip emptyCells directions
    let mazeWithDirections = foldl applyDirection emptyCells cellsWithDirection
    --let mazeWithDirection = replicate numberOfCells applyDirection emptyCells cellsWithDirection
    -- maze <- fillInMaze
    -- let initialDirections = Data.Sequence.fromList (fmap getInitialDirectionFromCell maze)
    -- let emptySequence = Data.Sequence.replicate 25 Nothing
    --yolo <- return 5
    print "Hello"













