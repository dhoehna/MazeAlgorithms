module Cell where

data Cell = Cell Bool Bool Bool Bool Int Int    

cellConstructor :: Bool -> Bool -> Bool -> Bool -> Int -> Int -> Cell
cellConstructor hasNorthNeighbor hasSouthNeighbor hasEastNeighbor hasWestNeighbor row column =  Cell hasNorthNeighbor hasSouthNeighbor hasEastNeighbor hasWestNeighbor row column




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
