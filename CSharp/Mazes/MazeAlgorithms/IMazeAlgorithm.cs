using Grid;
using System;
using System.Collections.Generic;
using System.Text;

namespace MazeAlgorithms
{
    public interface IMazeAlgorithm
    {
        void TurnGridIntoMaze(IGrid gridToTurnIntoAMaze);
    }
}
