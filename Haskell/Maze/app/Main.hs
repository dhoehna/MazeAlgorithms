module Main where
import Maze
import Cell
import System.Random

getRandomNumber :: IO Int
getRandomNumber = randomRIO(0::Int, 1::Int)

getRandomNumberFromList :: Int -> Int-> [Int] -> Int
getRandomNumberFromList row column randomNumbers = randomNumbers !! (column + (maxWidth * row))

fillInMaze :: IO Maze
fillInMaze = do   
    randomNumbers <- sequence [getRandomNumber |
                                xCoordinate <- [0..(maxWidth - 1)],
                                yCoordinate <- [0..(maxHeigth - 1)]]
                                
    return [makeCellWithNeighbor maxWidth xCoordinate yCoordinate (randomNumbers !! (getRandomNumberFromList yCoordinate xCoordinate randomNumbers)) | 
                                xCoordinate <- [0..(maxWidth - 1)],
                                yCoordinate <- [0..(maxHeigth - 1)]]

main :: IO ()
main = do
    maze <- fillInMaze
    print maze
    
--Next items
-- 1. Include depth.
-- 2. Include color
-- 3. Include PNG printing.













