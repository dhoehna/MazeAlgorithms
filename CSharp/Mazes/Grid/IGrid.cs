
using System;
using System.Collections.Generic;
using System.Text;
using static Grid.Grid;

namespace Grid
{
    public interface IGrid
    {
        void Connect(Room roomToConnectWith, Direction directionToConnect);
    }
}
