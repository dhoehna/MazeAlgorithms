module Cell where

data Cell = Cell Bool Bool Bool Bool Int Int Bool Int

instance Show Cell where
    show (Cell north south east west row column _ _) = ((show north) ++ " " ++ (show south) ++ " " ++ (show east) ++ " " ++ (show west) ++ " " ++ (show row) ++ " " ++ (show column) ++ "\n")

makeCellWithNeighbor :: Int -> Int -> Int -> Int -> Cell
makeCellWithNeighbor maxWidth row column randomNumber = 
    -- If on the north wall and not in the North East corner
    if row == 0 && column < (maxWidth - 1) then Cell False False True False row column False 0
    
    -- if on the east wall and not in the north east corner
    else if row > 0 && column == (maxWidth - 1) then Cell True False False False row column False 0
    
    -- if not on the north wall, the east wall, or the north-east corner
    else if row > 0 && column < (maxWidth - 1) then makeCellInRandomDirection row column randomNumber
    
    --If in the north east corner
    else Cell False False False False row column False 0
    

    
makeCellInRandomDirection :: Int -> Int -> Int -> Cell
makeCellInRandomDirection row column randomNumber =
    if randomNumber == 0 then Cell True False False False row column False 0
    else Cell False False True False row column False 0



--newtype HasNorthNeighbor = HasNorthNeighbor Bool
--newtype HasSouthNeighbor = HasSouthNeighbor Bool
--newtype HasEastNeighbor = HasEastNeighbor Bool
--newtype HasWestNeighbor = HasWestNeighbor Bool
--newtype Row = Row Integer
--newtype Column = Column Integer
--  
--data Cell = MakeCell 
--    { 
--       hasNorthNeighbor :: HasNorthNeighbor
--     , hasSouthNeighbor :: HasSouthNeighbor
--     , hasEastNeighbor :: HasEastNeighbor
--     , hasWestNeighbor :: HasWestNeighbor
--     , row :: Row
--     , column :: Column
--    }
