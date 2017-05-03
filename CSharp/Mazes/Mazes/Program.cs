using Grid;
using MazeAlgorithms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mazes
{
    class Program
    {
        static void Main(string[] args)
        {
            IGrid grid = new Grid.Grid(5, 5);
            IMazeAlgorithm binaryAlgorithm = new Binary();

            MazeGenerator.Generator generator = new MazeGenerator.Generator(grid, binaryAlgorithm);
            generator.ApplyAlgorithm();
        }
    }
}
