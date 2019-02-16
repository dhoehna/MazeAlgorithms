module Main where
import Cell

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
canCellMakeEastNeighbor yPositionOfCell = yPositionOfCell < 4

getCellFromIndex :: Maze -> Int -> Int -> Int -> Cell
getCellFromIndex maze width heigth index = maze !! (width + (maxWidth * heigth))


fillInMaze :: Maze
fillInMaze = [cellConstructor False False False False xCoordinate yCoordinate | 
                                xCoordinate <- [0..maxWidth],
                                yCoordinate <- [0..maxHeigth]]
                                

addNeighbor :: Cell -> Cell
addNeighbor (_ _ _ _ row column) = 
    if row == 0 && column < (maxWidth - 1) then Cell False False True False row column
                                

--If on the north wall make neighbor to the east
 --
--If on the east wall make neighbor to the north
--Otherwise pick north or east
--If on north east corner don't do anything


main :: IO ()
main = do
    putStrLn "Hello"
    --putStrLn fillInMaze
