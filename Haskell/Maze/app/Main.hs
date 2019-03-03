module Main where
import Maze
import Cell

getCellFromIndex :: Maze -> Int -> Int -> Int -> Cell
getCellFromIndex maze width heigth index = maze !! (width + (maxWidth * heigth))


fillInMaze :: Maze
fillInMaze = [makeCellWithNeighbor maxWidth xCoordinate yCoordinate | 
                                xCoordinate <- [0..maxWidth],
                                yCoordinate <- [0..maxHeigth]]
                                
                                

--If on the north wall make neighbor to the east
 --
--If on the east wall make neighbor to the north
--Otherwise pick north or east
--If on north east corner don't do anything


main :: IO ()
main = do
    putStrLn "Hello"
    --putStrLn fillInMaze
