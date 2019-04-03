module Main where
import Maze
import Cell

fillInMaze :: Maze
fillInMaze = [makeCellWithNeighbor maxWidth xCoordinate yCoordinate | 
                                xCoordinate <- [0..maxWidth],
                                yCoordinate <- [0..maxHeigth]]

main :: IO ()
main = do
    print (Cell True True True True 0 0)
    
