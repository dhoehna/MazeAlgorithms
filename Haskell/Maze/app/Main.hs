module Main where
import Maze
import Cell
import System.Random
import Control.Monad
import Data.Sequence
import Common

directions :: Seq (Maybe Direction)
directions = Data.Sequence.singleton Nothing

getRandomNumber :: IO Int
getRandomNumber = randomRIO(0::Int, 1::Int)

getRandomNumberFromList :: Int -> Int-> [Int] -> Int
getRandomNumberFromList row column randomNumbers = randomNumbers !! (column + (maxWidth * row))

fillInMaze :: IO Maze
fillInMaze = do   
    randomNumbers <- Control.Monad.replicateM numberOfCells getRandomNumber
    return [makeCellWithNeighbor maxWidth xCoordinate yCoordinate (randomNumbers !! (getRandomNumberFromList yCoordinate xCoordinate randomNumbers)) | 
                                xCoordinate <- [0..(maxWidth - 1)],
                                yCoordinate <- [0..(maxHeigth - 1)]]

                                

getCellFromIndex :: Maze -> Int -> Int -> Cell
getCellFromIndex maze width heigth = maze !! (width + (maxWidth * heigth))


--addBirirectionalNeighbor

--Take initialDirections apply a function to get the breadcrumb direction.
--SOmething with Data.Sequence.mapWithIndex.
main :: IO ()
main = do
    maze <- fillInMaze
    let initialDirections = Data.Sequence.fromList (fmap getInitialDirectionFromCell maze)
    let emptySequence = Data.Sequence.replicate 25 Nothing
    --yolo <- return 5
    print "Hello"













