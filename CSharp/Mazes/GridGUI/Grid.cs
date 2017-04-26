using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GridGUI
{
    public class Grid
    {
        private Room[][] rooms;

        public Grid(int numberOfRows, int numberOfColumns)
        {
            rooms = new Room[numberOfRows][];

            for(int x = 0; x < numberOfRows; x++)
            {
                rooms[x] = new Room[numberOfColumns];
            }

            for(int rowIndex = 0; rowIndex < numberOfRows; rowIndex++)
            {
                for(int columnIndex = 0; columnIndex < numberOfColumns; columnIndex++)
                {
                    rooms[rowIndex][columnIndex] = new Room();
                }
            }
        }
    }
}
