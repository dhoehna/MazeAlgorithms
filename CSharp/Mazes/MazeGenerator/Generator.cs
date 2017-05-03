using Grid;
using MazeAlgorithms;
using System;

namespace MazeGenerator
{
    public class Generator
    {
        private IGrid gridToManipulate;
        private IMazeAlgorithm algorithmToApply;

        public Generator(IGrid gridToManipulate, IMazeAlgorithm algorithmToApply)
        {
            this.gridToManipulate = gridToManipulate;
            this.algorithmToApply = algorithmToApply;
        }

        public void ApplyAlgorithm()
        {
            algorithmToApply.TurnGridIntoMaze(gridToManipulate);
        }
    }
}
