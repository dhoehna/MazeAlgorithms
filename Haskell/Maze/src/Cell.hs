module Cell where
import Common
  
data Cell = Cell 
    { 
       hasNorthNeighbor :: Bool
      ,hasSouthNeighbor :: Bool
      ,hasEastNeighbor :: Bool
      ,hasWestNeighbor :: Bool
      ,row :: Int
      ,column :: Int
      ,hasBeenVisited :: Bool
      ,depth :: Int
    }
    
makeCellWithIndex :: Index -> Cell
makeCellWithIndex index = do
    let point = convertIndexToPoint index
    Cell False False False False (fst point) (snd point) False 0

makeCellWithDirection :: Bool -> Bool -> Bool -> Bool -> Cell
makeCellWithDirection north south east west = Cell north south east west 0 0 False 0
    
instance Show Cell where
    show (Cell north south east west row column _ _) = unwords $ map show [north, south, east, west] ++ map show [row, column]