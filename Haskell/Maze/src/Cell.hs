module Cell where
import System.Random

data Cell = Cell Bool Bool Bool Bool Int Int

instance Show Cell where
    show _ = "Hi"

makeCellWithNeighbor :: Int -> Int -> Int -> IO Cell
makeCellWithNeighbor maxWidth row column = 
    -- If on the north wall and not in the North East corner
    if row == 0 && column < (maxWidth - 1) then return  (Cell False False True False row column)
    
    -- if on the east wall and not in the north east corner
    else if row > 0 && column == (maxWidth - 1) then return (Cell True False False False row column)
    
    -- if not on the north wall, the east wall, or the north-east corner
    else if row > 0 && column < (maxWidth - 1) then makeCellInRandomDirection row column
    
    --If in the north east corner
    else return (Cell False False False False row column)
    
getRandomNumber :: IO Int
getRandomNumber = randomRIO(0::Int, 1::Int)
    
makeCellInRandomDirection :: Int -> Int -> IO Cell
makeCellInRandomDirection row column = do
    randomNumber <- getRandomNumber
    if randomNumber == 0 then return (Cell True False False False row column)
    else return (Cell False False True False row column)



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
