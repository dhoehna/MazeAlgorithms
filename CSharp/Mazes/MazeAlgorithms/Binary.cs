
using System;
using Grid;
namespace MazeAlgorithms
{
    public class Binary :IMazeAlgorithm
    {
        public void TurnGridIntoMaze(IGrid gridToManipulate)
        {
            foreach(Room room in gridToManipulate.GetRoomsSequantially())
            {

            }
        }
    }
}
