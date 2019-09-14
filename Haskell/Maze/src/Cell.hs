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
    
makeFreshCell :: Cell
makeFreshCell = Cell False False False False 0 0 False 0
    
instance Show Cell where
    show (Cell north south east west row column _ _) = unwords $ map show [north, south, east, west] ++ map show [row, column]