using Grid;
using MazeAlgorithms;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mazes
{
    class Program
    {
        static void Main(string[] args)
        {
            /*
             * This is a 5 by 5 grid.
             * Each cell is 10 pixles
             * so that means the image has to be 10 * 5, or 500 pixles wide and long
             */
            Bitmap b = new Bitmap(500, 500);

            Graphics g = Graphics.FromImage(b);

            g.Clear(Color.Green);

            b.Save("Hello.png");

            g.Dispose();

            b.Dispose();
            //IGrid grid = new Grid.Grid(5, 5);
            //IMazeAlgorithm binaryAlgorithm = new Binary();

            //MazeGenerator.Generator generator = new MazeGenerator.Generator(grid, binaryAlgorithm);
            //generator.ApplyAlgorithm();
        }
    }
}
