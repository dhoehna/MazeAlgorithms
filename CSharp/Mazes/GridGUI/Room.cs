using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GridGUI
{
    public class Room
    {
        public int row { get; private set; }
        public int column { get; private set; }

        public Room(int row, int column)
        {
            this.row = row;
            this.column = column;
        }
    }
}
