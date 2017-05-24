using DistanceAlgorithms;
using Grid;
using MazeAlgorithms;

namespace MazeGenerator
{
    public class Generator
    {
        private IGrid gridToManipulate;
        private IMazeAlgorithm algorithmToApply;
        private IDistanceAlgorithm solver;

        public Generator(IGrid gridToManipulate, IMazeAlgorithm algorithmToApply, IDistanceAlgorithm solver)
        {
            this.gridToManipulate = gridToManipulate;
            this.algorithmToApply = algorithmToApply;
            this.solver = solver;
        }

        public void ApplyAlgorithm()
        {
            algorithmToApply.TurnGridIntoMaze(gridToManipulate);
        }

        public int SolveMaze(GridPosition startingCell)
        {
            if (gridToManipulate.IsValidPosition(startingCell))
            {
                return solver.GetDistances(gridToManipulate, startingCell);
            }
            else
            {
                return 0;
            }
            
        }
    }
}