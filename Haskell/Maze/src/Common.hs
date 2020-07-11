module Common where

data Direction = North | South | East | West | None | Random deriving (Eq)

type Index = Int

type Point = (Int, Int)

maxWidth :: Int
maxWidth = 5

maxHeigth :: Int
maxHeigth = 5

numberOfCells :: Int
numberOfCells = maxWidth * maxHeigth

convertIndexToPoint :: Index -> Point
convertIndexToPoint index
  | isValidIndex index = (index `div` maxWidth, index `mod` maxWidth)
  | otherwise    = (-1, -1)
    
isValidIndex :: Index -> Bool
isValidIndex index = index >= 0 && index < numberOfCells