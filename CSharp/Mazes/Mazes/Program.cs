using MazeAlgorithms;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Grid;
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

            List<Room> rooms = grid.GetRooms();

            

            foreach (Room room in rooms)
            {
                int xOfUpperLeft = room.column * 100;
                int yOfUpperLeft = room.row * 100;
                int xOfLowerRight = (room.column * 100) + 100;
                int yOfLowerRight = (room.row * 100) + 100;

                //If on north wall
                if (room.row == 0)
                {
                    tool.DrawLine(blackPen, xOfUpperLeft, yOfUpperLeft, xOfUpperLeft + 100, 0);
                }

                //if on south wall
                if (room.row == grid.GetRows() - 1)
                {
                    tool.DrawLine(blackPen, xOfLowerRight - 100, yOfLowerRight, xOfLowerRight, yOfLowerRight);
                }

                //If on east wall
                if (room.column == 0)
                {
                    tool.DrawLine(blackPen, xOfUpperLeft, yOfUpperLeft, xOfUpperLeft, yOfUpperLeft + 100);
                }

                //If on west wall
                if (room.column == grid.GetColumns() - 1)
                {
                    tool.DrawLine(blackPen, xOfLowerRight, yOfUpperLeft, xOfLowerRight, yOfUpperLeft + 100);
                }

                //wait.  So a neighbor should not have a line drawn between them.  So each cel will
                //worry about the north and east walls.

                //Not on the north row
                if(!room.Neighbors().Contains(Direction.NORTH))
                {
                    tool.DrawLine(blackPen, xOfUpperLeft, yOfUpperLeft, xOfUpperLeft + 100, yOfUpperLeft);
                }

                if(!room.Neighbors().Contains(Direction.EAST))
                {
                    tool.DrawLine(blackPen, xOfLowerRight, yOfLowerRight - 100, xOfLowerRight, yOfLowerRight);
                }
            }

            gridPng.Save("Hello.png");
            blackPen.Dispose();
            tool.Dispose();
            gridPng.Dispose();
        }
    }
}
