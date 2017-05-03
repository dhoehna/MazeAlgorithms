
using System;
using System.Collections.Generic;
using System.Text;
using static Grid.Grid;

namespace Grid
{
    public interface IGrid
    {
        void Connect(Room room, Direction directionToConnect);
        List<Room> GetRooms();
        int GetRows();
        int GetColumns();
        Room this[int row, int column] { get; }
    }
}
