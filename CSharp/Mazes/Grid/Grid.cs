using Grid;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GridGUI
{
    public sealed class Grid : IGrid
    {
        public enum Direction
        {
            NORTH,
            SOUTH,
            EAST,
            WEST
        }

        
        private Room[][] rooms;
        private int rows;
        private int columns;

        public Grid(int numberOfRows, int numberOfColumns)
        {
            rooms = new Room[numberOfRows][];
            rows = numberOfRows;
            columns = numberOfColumns;
            for (int x = 0; x < numberOfRows; x++)
            {
                rooms[x] = new Room[numberOfColumns];
            }

            for (int rowIndex = 0; rowIndex < numberOfRows; rowIndex++)
            {
                for (int columnIndex = 0; columnIndex < numberOfColumns; columnIndex++)
                {
                    rooms[rowIndex][columnIndex] = new Room(rowIndex, columnIndex);
                }
            }
        }

        public void Connect(Room room, Direction directionToConect)
        {
            Room roomToConnectWith = null;

            GridPosition positionOfNeighborToConnectWith = RoomHelper.GetNeighborLocation(room, directionToConect);

            if(IsValidPosition(positionOfNeighborToConnectWith))
            {
                roomToConnectWith = this[positionOfNeighborToConnectWith.row, positionOfNeighborToConnectWith.column];
            }

            if(roomToConnectWith != null)
            {
                room.Connect(roomToConnectWith, directionToConect);
            }
        }

        public Room this[int row, int column]
        {
            get
            {
                if (IsValidPosition(new GridPosition(row, column)))
                {
                    return rooms[row][column];
                }
                else
                {
                    return null;
                }
            }
        }

        private bool IsValidPosition(GridPosition gridPosition)
        {
            if(gridPosition.row < 0 || gridPosition.row > rows)
            {
                return false;
            }

            if(gridPosition.column < 0 || gridPosition.column > columns)
            {
                return false;
            }

            return true;
        }



        


    }
}
