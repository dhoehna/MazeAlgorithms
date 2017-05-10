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
             * Each cell is 100 pixles
             * so that means the image has to be 10 * 5, or 500 pixles wide and long
             */
            Bitmap b = new Bitmap(500, 500);

            Graphics g = Graphics.FromImage(b);


            Pen blackPen = new Pen(Color.Black, 3);

            //Border
            g.DrawRectangle(blackPen, 0, 0, 500, 500);

            g.DrawLine(blackPen, 100, 0, 100, 500);
            g.DrawLine(blackPen, 200, 0, 200, 500);
            g.DrawLine(blackPen, 300, 0, 300, 500);
            g.DrawLine(blackPen, 400, 0, 400, 500);

            g.DrawLine(blackPen, 0, 100, 500, 100);
            g.DrawLine(blackPen, 0, 200, 500, 200);
            g.DrawLine(blackPen, 0, 300, 500, 300);
            g.DrawLine(blackPen, 0, 400, 500, 400);


            b.Save("Hello.png");

            blackPen.Dispose();

            g.Dispose();

            b.Dispose();
            //IGrid grid = new Grid.Grid(5, 5);
            //IMazeAlgorithm binaryAlgorithm = new Binary();

            //MazeGenerator.Generator generator = new MazeGenerator.Generator(grid, binaryAlgorithm);
            //generator.ApplyAlgorithm();
        }
    }
}
