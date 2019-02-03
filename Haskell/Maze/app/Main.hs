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

fillInMaze :: [Bool -> Bool -> Bool -> Bool -> Int -> Int -> Cell]
fillInMaze = [cellConstructor | cell <- [0..numberOfCells]]

getRandomCharacter :: Char
getRandomCharacter = 'a'


main :: IO ()
main = do
    putStrLn "Hello"
    --putStrLn fillInMaze
