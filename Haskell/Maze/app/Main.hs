module Main where
import Maze
import Cell
import System.Random
import Control.Monad

getRandomNumber :: IO Int
getRandomNumber = randomRIO(0::Int, 1::Int)

getRandomNumberFromList :: Int -> Int-> [Int] -> Int
getRandomNumberFromList row column randomNumbers = randomNumbers !! (column + (maxWidth * row))

fillInMaze :: IO Maze
fillInMaze = do   
    randomNumbers <- replicateM numberOfCells getRandomNumber
                                
    return [makeCellWithNeighbor maxWidth xCoordinate yCoordinate (randomNumbers !! (getRandomNumberFromList yCoordinate xCoordinate randomNumbers)) | 
                                xCoordinate <- [(maxWidth - 1)..0],
                                yCoordinate <- [0..(maxHeigth - 1)]]

main :: IO ()
main = do
    maze <- fillInMaze
    print "Hello"
    

--Populate maze with cells.
--Assign neighbors
--SOlve.    
    
--Next items
-- 1. Include depth.
    --We need a depth first search
    --We need to enable neighbors both ways.
-- 2. Include color
-- 3. Include PNG printing.













