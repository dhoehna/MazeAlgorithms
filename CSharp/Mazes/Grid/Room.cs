using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Grid.Grid;

namespace Grid
{
    public sealed class Room
    {
        public int row { get; private set; }
        public int column { get; private set; }
        public int distance { get; set; }
        public bool visited { get; set; }

        private Dictionary<Direction, Room> neighbors;
        

        public Room(int row, int column)
        {
            this.row = row;
            this.column = column;

            neighbors = new Dictionary<Direction, Room>();
        }

        public Room(GridPosition gridPosition)
        {
            this.row = gridPosition.row;
            this.column = gridPosition.column;

            neighbors = new Dictionary<Direction, Room>();
        }

        public void Connect(Room roomToConnectWith, Direction direction)
        {
            if(neighbors.ContainsKey(direction))
            {
                neighbors.Remove(direction);
            }

            neighbors[direction] = roomToConnectWith;
        }

        public List<Direction> Neighbors()
        {
            return neighbors.Keys.ToList();
        }

        public List<Room> NeighborsAsRooms()
        {
            return neighbors.Values.ToList();
        }

    }
}
