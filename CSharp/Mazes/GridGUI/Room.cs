using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static GridGUI.Grid;

namespace GridGUI
{
    public sealed class Room
    {
        public int row { get; private set; }
        public int column { get; private set; }

        private Room northNeighbor;
        private Room southNeighbor;
        private Room eastNeighbor;
        private Room westNeighbor;

        public Room(int row, int column)
        {
            this.row = row;
            this.column = column;

            northNeighbor = null;
            southNeighbor = null;
            eastNeighbor = null;
            westNeighbor = null;
        }

        public void Connect(Room roomToConnectWith, Direction direction)
        {
            if(direction == Direction.NORTH)
            {

            }
        }

    }
}
