
using System;
using Grid;
using System.Collections.Generic;
using static Grid.Grid;

namespace MazeAlgorithms
{
    public class Binary :IMazeAlgorithm
    {
        public void TurnGridIntoMaze(IGrid gridToManipulate)
        {
            List<Room> rooms = gridToManipulate.GetRooms();
            int rows = gridToManipulate.GetRows();
            int columns = gridToManipulate.GetColumns();
            foreach(Room room in rooms)
            {
                List<Direction> edges = RoomHelper.GetBoundriesRoomIsOn(room, rows, columns);
            }
        }
    }
}
