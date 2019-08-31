module Maze where
import Cell
import Common
import System.Random

type Maze = [Cell]
type Index = Int
type Point = (Int, Int)

maxWidth :: Int
maxWidth = 5

maxHeigth :: Int
maxHeigth = 5

numberOfCells :: Int
numberOfCells = maxWidth * maxHeigth

getDirection :: Index -> IO Direction
getDirection index
    | row == 0 && column /= maxWidth - 1 = pure East
    | row /= 0 && column == maxWidth - 1 = pure North
    | otherwise = getRandomDirection index
    where
        (row, column) = convertIndexToPoint index
        
-- | Check if a point is within boundries of the maze
isValidPoint :: Point -> Bool
isValidPoint (row, column) = (row >= 0 && row < maxHeigth) && (column >= 0 && column < maxWidth)
        
convertPointToIndex :: Point -> Index
convertPointToIndex point@(row, column)
  | isValidPoint point = column + row * maxWidth
  | otherwise    = (-1)
  -- ^ annying thing in haskell is that negative numbers must be in parenthesis
    
-- | Convert an index to a cartesian coord
--   returns (-1, -1) if invalid index given
convertIndexToPoint :: Index -> Point
convertIndexToPoint index
  | isValidIndex index = (index `div` maxWidth, index `mod` maxWidth)
  | otherwise    = (-1, -1)
    
isValidIndex :: Index -> Bool
isValidIndex index = index >= 0 && index < numberOfCells

-- | Return the next index when you move in a certain direction from a given index
move :: Index -> Direction -> Index
move index direction = convertPointToIndex $ case direction of
  North -> (row - 1, column)
  South -> (row + 1, column)
  East -> (row, column + 1)
  West -> (row, column - 1)
  where
    (row, column) = convertIndexToPoint index

getRandomDirection :: Index -> IO Direction
-- getChoiceRan i = let valid = validMoves i in pure . (valid !!) =<< randomRIO (0, length valid - 1)
getRandomDirection index = do
  let valid = getValidMovesFromIndex index
  -- ^ get valid moves from given index
  nth <- randomRIO(0, length valid - 1)
  -- ^ return random number in range of number of valid moves
  pure $ valid !! nth
  -- ^ select direction based on random index
  
  -- | Return a list of valid directions at a given index
getValidMovesFromIndex :: Index -> [Direction]
getValidMovesFromIndex index = filter (isValidIndex . move index) [North, South, East, West]

-- getNeighborWithDirection :: Maze -> Cell -> Maybe Direction
-- getNeighborWithDirection maze cell@(Cell True _ _ _ _ _ _ _) = grabNeighborFromDirection maze cell North
-- getNeighborWithDirection maze cell@(Cell _ _ True _ _ _ _ _) = grabNeighborFromDirection maze cell East
-- getNeighborWithDirection maze cell@(Cell False _ False _ _ _ _ _) = Cell False False False False (maxWidth - 1) 0 False 0

-- grabNeighborFromDirection :: Maze -> Cell -> Direction -> Cell
--Get north neighbor and give it a south neighbor
-- grabNeighborFromDirection _ _ North = Cell False False False False 0 0 False 0
--Get East neighbor and give it a west neighbor
-- grabNeighborFromDirection _ _ East = Cell False False False False 0 0 False 0

--getCellFromRowAndColumn :: Maze -> int -> int -> Direction -> Cell
--getCellFromRowAndColumn _ row column North = 
--getIndexFromRowAndColumn :: int -> int -> int
--getIndexFromRowAndColumn row column = 
    
    