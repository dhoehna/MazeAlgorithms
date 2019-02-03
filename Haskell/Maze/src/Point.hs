module Point where

newtype XCoordinant = XCoordinant Integer
newtype YCoordinant = YCoordinant Integer

data Point = Point XCoordinant YCoordinant

makePoint :: XCoordinant -> YCoordinant -> Point
makePoint x y = Point x y