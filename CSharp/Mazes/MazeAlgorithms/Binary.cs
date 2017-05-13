
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


                

                if(IsRoomOnNorthBoundry(boundries) && IsRoomOnEastBoundry(boundries))
                {
                    //Don't do anything.
                }
                else if(IsRoomOnNorthBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.EAST;
                }
                else if (IsRoomOnEastBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.NORTH;
                }
                else
                {
                    int direction = randomDirectionGenerator.Next(0, 2);

                    if(direction == 0)
                    {
                        directionToConnect = ValidConnectionDirections.NORTH;
                    }
                    else if(direction == 1)
                    {
                        directionToConnect = ValidConnectionDirections.EAST;
                    }
                }


                if(directionToConnect != null)
                {
                    gridToManipulate.Connect(room, (Direction)directionToConnect);
                }

            }
        }

        private bool IsRoomOnNorthBoundry(List<Direction> boundries)
        {
            return boundries.Contains(Direction.NORTH);
        }

        private bool IsRoomOnSouthBoundry(List<Direction> boundries)
        {
            return boundries.Contains(Direction.SOUTH);
        }

        private bool IsRoomOnEastBoundry(List<Direction> boundries)
        {
            return boundries.Contains(Direction.EAST);
        }

        private bool IsRoomOnWestBoundry(List<Direction> boundries)
        {
            return boundries.Contains(Direction.WEST);
        }
    }
}
