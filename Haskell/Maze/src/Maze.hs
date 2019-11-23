module Maze where
import Cell
import Common
import System.Random

type Maze = [Cell]



--getDirection :: Index -> IO Direction
-- getDirection index
    -- | row == 0 && column /= maxWidth - 1 = pure East
    -- | row /= 0 && column == maxWidth - 1 = pure North
    -- | otherwise = Ran
    -- where
        -- (row, column) = convertIndexToPoint index
       
        
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


-- | Return the next index when you move in a certain direction from a given index
move :: Index -> Direction -> Index
move index direction = convertPointToIndex $ case direction of
  North -> (row - 1, column)
  South -> (row + 1, column)
  East -> (row, column + 1)
  West -> (row, column - 1)
  where
    (row, column) = convertIndexToPoint index

--getRandomDirection :: Index -> IO Direction
-- getChoiceRan i = let valid = validMoves i in pure . (valid !!) =<< randomRIO (0, length valid - 1)
--getRandomDirection index = do
  --let valid = getValidMovesFromIndex index
  -- ^ get valid moves from given index
  --nth <- randomRIO(0, length valid - 1)
  -- ^ return random number in range of number of valid moves
  --pure $ valid !! nth
  -- ^ select direction based on random index

getRandomDirection :: IO Direction
getRandomDirection = do
    randomNumber <- randomRIO(0, 1)
    pure $ [North, East] !! randomNumber  
  
  -- | Return a list of valid directions at a given index
getValidMovesFromIndex :: Index -> [Direction]
getValidMovesFromIndex index = filter (isValidIndex . move index) [North, South, East, West]