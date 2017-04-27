using GridGUI;
using System;
using System.Collections.Generic;
using System.Text;
using static GridGUI.Grid;

namespace Grid
{
    interface IGrid
    {
        void Connect(Room roomToConnectWith, Direction directionToConnect);
    }
}
