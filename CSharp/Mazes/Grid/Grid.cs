using System;
using System.Collections;
using System.Collections.Generic;

namespace Grid
{
    public sealed class Grid :  IGrid
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

        public int GetRows()
        {
            return rows;
        }

        public int GetColumns()
        {
            return columns;
        }

        public void Connect(Room room, Direction directionToConect)
        {
            Room roomToConnectWith = null;

            GridPosition positionOfNeighborToConnectWith = RoomHelper.GetNeighborLocation(room, directionToConect);

            if (IsValidPosition(positionOfNeighborToConnectWith))
            {
                roomToConnectWith = this[positionOfNeighborToConnectWith.row, positionOfNeighborToConnectWith.column];
            }

            if (roomToConnectWith != null)
            {
                RoomHelper.ConnectRooms(room, roomToConnectWith, directionToConect);
            }
        }

        public List<Room> GetRooms()
        {
            List<Room> roomsToReturn = new List<Room>();
            for (int rowIndex = 0; rowIndex < rows; rowIndex++)
            {
                for (int columnIndex = 0; columnIndex < columns; columnIndex++)
                {
                    roomsToReturn.Add(rooms[rowIndex][columnIndex]);
                }
            }

            return roomsToReturn;
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

        public bool IsValidPosition(GridPosition gridPosition)
        {
            if (gridPosition.row < 0 || gridPosition.row >= rows)
            {
                return false;
            }

            if (gridPosition.column < 0 || gridPosition.column >= columns)
            {
                return false;
            }

            return true;
        }

        
    }
}
