
using System;
using Grid;
using System.Collections.Generic;
using static Grid.Grid;
using System.Linq;

namespace MazeAlgorithms
{
    public class Binary : IMazeAlgorithm
    {

        private enum ValidConnectionDirections
        {
            NORTH = Direction.NORTH,
            EAST = Direction.EAST
        }

        public void TurnGridIntoMaze(IGrid gridToManipulate)
        {
            List<Room> rooms = gridToManipulate.GetRooms();
            int rows = gridToManipulate.GetRows();
            int columns = gridToManipulate.GetColumns();
            Random randomDirectionGenerator = new Random();

            foreach (Room room in rooms)
            {
                List<Direction> boundries = RoomHelper.GetBoundriesRoomIsOn(room, rows, columns);

                ValidConnectionDirections? directionToConnect = null;
                //If not on the north or east edge
                if(!(IsRoomOnNorthBoundry(boundries) || IsRoomOnEastBoundry(boundries)))
                {
                    int direction = randomDirectionGenerator.Next(0, 1);
                    Console.WriteLine(direction);
                    if(direction == 0)
                    {
                        directionToConnect = ValidConnectionDirections.NORTH;
                    }
                    else if (direction == 1)
                    {
                        directionToConnect = ValidConnectionDirections.EAST;
                    }
                }
                else if(IsRoomOnNorthBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.EAST;
                }
                else if (IsRoomOnEastBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.NORTH;
                }

                if(directionToConnect != null)
                {
                    gridToManipulate.Connect(room, (Direction)directionToConnect);
                }
            }
        }

        private bool IsRoomOnNorthBoundry(List<Direction> boundries)
        {
            return boundries.Any(boundry => boundry.Equals(Direction.NORTH));
        }

        private bool IsRoomOnSouthBoundry(List<Direction> boundries)
        {
            return boundries.Any(boundry => boundry.Equals(Direction.SOUTH));
        }

        private bool IsRoomOnEastBoundry(List<Direction> boundries)
        {
            return boundries.Any(boundry => boundry.Equals(Direction.EAST));
        }

        private bool IsRoomOnWestBoundry(List<Direction> boundries)
        {
            return boundries.Any(boundry => boundry.Equals(Direction.WEST));
        }
    }
}
