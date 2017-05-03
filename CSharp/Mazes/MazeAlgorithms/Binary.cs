
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
            NULL = 0,
            NORTH = 1,
            EAST
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

                ValidConnectionDirections directionToConnect = ValidConnectionDirections.NULL;
                //If not on the north or east edge
                if(!(IsRoomOnNorthBoundry(boundries) || IsRoomOnEastBoundry(boundries)))
                {
                    directionToConnect = (ValidConnectionDirections) randomDirectionGenerator.Next((int)ValidConnectionDirections.NORTH, (int)ValidConnectionDirections.EAST);
                }
                else if(IsRoomOnNorthBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.EAST;
                }
                else if (IsRoomOnEastBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.NORTH;
                }

                if(directionToConnect != ValidConnectionDirections.NULL)
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
