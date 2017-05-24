using Grid;
using MazeAlgorithms;
using Solver;

namespace MazeGenerator
{
    public class Generator
    {
        private IGrid gridToManipulate;
        private IMazeAlgorithm algorithmToApply;
        private ISolver solver;

        public Generator(IGrid gridToManipulate, IMazeAlgorithm algorithmToApply)
        {
            this.gridToManipulate = gridToManipulate;
            this.algorithmToApply = algorithmToApply;
        }

        public void ApplyAlgorithm()
        {
            algorithmToApply.TurnGridIntoMaze(gridToManipulate);
        }

        public void SolveMaze()
        {
            solver.Solve(gridToManipulate);
        }
    }
}
