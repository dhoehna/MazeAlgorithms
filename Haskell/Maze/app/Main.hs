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

                                

-- getCellFromIndex :: Maze -> Int -> Int -> Cell
-- getCellFromIndex maze width heigth = maze !! (width + (maxWidth * heigth))

applyDirection :: (Cell, Direction) -> Cell
applyDirection cellsWithDirection@(cell, direction)
 | direction == North = ix index %~ cell {hasNorthNeighbor = true}
 | direction == South = ix index %~ cell {hasNorthNeighbor = true}
 | direction == East = ix index %~ cell {hasNorthNeighbor = true}
 | direction == West = ix index %~ cell {hasNorthNeighbor = true}
 where
    index = convertPointToIndex (cell.row, cell.column)

--addBirirectionalNeighbor

--Take initialDirections apply a function to get the breadcrumb direction.
--SOmething with Data.Sequence.mapWithIndex.
main :: IO ()
main = do
    let emptyCells = replicate numberOfCells makeFreshCell
    let directions = replicate numberOfCells getDirection
    let cellsWithDirection = zip emptyCells directions
    -- maze <- fillInMaze
    -- let initialDirections = Data.Sequence.fromList (fmap getInitialDirectionFromCell maze)
    -- let emptySequence = Data.Sequence.replicate 25 Nothing
    --yolo <- return 5
    print "Hello"













