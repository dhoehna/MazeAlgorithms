using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static GridGUI.Grid;

namespace GridGUI
{
    public sealed class RoomHelper
    {

        public static GridPosition GetNeighborLocation(Room room, Direction direction)
        {
            if(direction == Direction.NORTH)
            {
                return new GridPosition(room.row - 1, room.column);
            }
            else if (direction == Direction.SOUTH)
            {
                return new GridPosition(room.row + 1, room.column);
            }
            else if (direction == Direction.EAST)
            {
                return new GridPosition(room.row, room.column - 1);
            }
            else if (direction == Direction.WEST)
            {
                return new GridPosition(room.row, room.column + 1);
            }
            else
            {
                throw new ArgumentException($"{direction} is not a valid direction.");
            }
        }
    }
}
