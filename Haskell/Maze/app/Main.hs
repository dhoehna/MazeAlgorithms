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

applyDirection :: Maze -> (Cell, Direction) -> Cell
applyDirection _ (_, North) = makeFreshCell --maze & (ix index %~ cell {hasNorthNeighbor = true}) . (ix neighborIndex %~ neighborCell {hasSouthNeighbor = true}))
applyDirection _ (_, East) = makeFreshCell --maze & (ix index %~ cell {hasNorthNeighbor = true}) . (ix neighbotIndex %~ neighborCell {hasWestNeighbor = true}))
 --where
    --index = convertPointToIndex cell.row cell.column
    --neigborCell = getNeighborCellFromCell maze cell direction
    --neigborIndex = getNeighborIndexFromCell maze cell direction
    
getNeighborCellFromCell :: Maze -> Cell -> Direction -> Cell
getNeighborCellFromCell maze cell direction@North = makeFreshCell --maze !! getIndexFromPoint (row cell - maxWidth) column cell
getNeighborCellFromCell maze cell direction@East = makeFreshCell --maze !! getIndexFromPoint row cell (column cell + 1)
 
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
    --let mazeWithDirection = replicate numberOfCells applyDirection emptyCells cellsWithDirection
    -- maze <- fillInMaze
    -- let initialDirections = Data.Sequence.fromList (fmap getInitialDirectionFromCell maze)
    -- let emptySequence = Data.Sequence.replicate 25 Nothing
    --yolo <- return 5
    print "Hello"













