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

        public Generator(IGrid gridToManipulate, IMazeAlgorithm algorithmToApply, ISolver solver)
        {
            this.gridToManipulate = gridToManipulate;
            this.algorithmToApply = algorithmToApply;
            this.solver = solver;
        }

        public void ApplyAlgorithm()
        {
            algorithmToApply.TurnGridIntoMaze(gridToManipulate);
        }

        public void SolveMaze(GridPosition startingCell)
        {
            if (gridToManipulate.IsValidPosition(startingCell))
            {
                solver.Solve(gridToManipulate, startingCell);
            }
        }
    }
}