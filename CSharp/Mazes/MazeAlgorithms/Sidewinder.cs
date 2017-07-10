using System;
using Grid;
using System.Collections.Generic;
using System.Text;
using static Grid.Grid;
using System.Linq;

namespace MazeAlgorithms
{
    /// <summary>
    /// The Algorithm used to generate information for the maze and is used by another class to generate the actual rooms.
    /// </summary>
    public class Sidewinder : IMazeAlgorithm
    {
        private enum ValidConnectionDirections
        {
            NORTH = Direction.NORTH,
            EAST = Direction.EAST
        }

        public void TurnGridIntoMaze(IGrid gridToManipulate)
        {
            // Get the rooms that we are going to manipulate from the grid. For the sidewinder algorithm we will need a 2d array.
            List<Room> rooms = gridToManipulate.GetRooms();

            // Get the number of rows and columns that we will manipulate
            int rows = gridToManipulate.GetRows();
            int columns = gridToManipulate.GetColumns();

            // Get a random number from 0-1 that will determine if a room will go either NORTH or EAST
            Random randomNumGenerator = new Random();

            // Keep track of the run of the rooms that have been visited
            List<Room> roomsInRun = new List<Room>();

            foreach (Room room in rooms)
            {
                // Get the rooms that are on the boundaries of the grid
                List<Direction> boundries = RoomHelper.GetBoundriesRoomIsOn(room, rows, columns);

                ValidConnectionDirections? directionToConnect = null;

                // We are in a run until we reach the end of the row (or until we reach an eastern boundary). For this algorithm to work correctly we must
                // keep track of all the rooms in the current run and then erase them all to start a new run.
                roomsInRun.Add(room);


                if (IsRoomOnNorthBoundry(boundries) && IsRoomOnEastBoundry(boundries))
                {
                    //Don't do anything. This is the end of the grid.
                }
                else if (IsRoomOnNorthBoundry(boundries))
                {
                    directionToConnect = ValidConnectionDirections.EAST;
                }
                else if (IsRoomOnEastBoundry(boundries))
                {
                    // Randomly erases a northern boundary in a room in our current run. Then we will delete those rooms and start a new run.
                    directionToConnect = ValidConnectionDirections.NORTH;

                    int randomRoom = randomNumGenerator.Next(0, roomsInRun.Count);

                    gridToManipulate.Connect(roomsInRun[randomRoom], (Direction)directionToConnect);

                    // Now since the run is done we will delete the list roomsInRun.
                    roomsInRun.Clear();
                }
                // if the current room is not on a boundry then connect in a random direction
                else
                {
                    int direction = randomNumGenerator.Next(0, 2);

                    if (direction == 0)
                    {
                        directionToConnect = ValidConnectionDirections.NORTH;
                    }
                    else if (direction == 1)
                    {
                        directionToConnect = ValidConnectionDirections.EAST;
                    }
                }

                // if there is a direction to connect to
                if (directionToConnect != null)
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
