using Grid;
using MazeAlgorithms;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Grid.Grid;

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
            //Bitmap b = new Bitmap(500, 500);

            //Graphics g = Graphics.FromImage(b);


            //Pen blackPen = new Pen(Color.Black, 3);

            ////Border
            //g.DrawRectangle(blackPen, 0, 0, 500, 500);




            //b.Save("Hello.png");

            //blackPen.Dispose();

            //g.Dispose();

            //b.Dispose();
            IGrid grid = new Grid.Grid(5, 5);
            IMazeAlgorithm binaryAlgorithm = new Binary();

            MazeGenerator.Generator generator = new MazeGenerator.Generator(grid, binaryAlgorithm);
            generator.ApplyAlgorithm();

            Bitmap gridPng = new Bitmap(500, 500);
            Graphics tool = Graphics.FromImage(gridPng);
            Pen blackPen = new Pen(Color.Black, 3);

            //Draw border
            g.DrawRectangle(blackPen, 0, 0, 500, 500);

            List<Room> rooms = grid.GetRooms();

            foreach(Room room in rooms)
            {
                List<Direction> neighbors = room.Neighbors();

                if(room.row == 0 && neighbors.Any(neighbor => neighbor.Equals(Direction.EAST)))
                {

                }
            }

            gridPng.Save("Hello.png");
            blackPen.Dispose();
            tool.Dispose();
            gridPng.Dispose();
        }
    }
}
