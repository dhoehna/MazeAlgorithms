using MazeAlgorithms;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Grid;
using static Grid.Grid;
using DistanceAlgorithms;

namespace Mazes
{
    class Program
    {
        const int ROWS = 10;
        const int COLUMNS = 10;

        const int WIDTH_IN_PIXLES = 500;
        const int HEITH_IN_PIXLES = 500;

        const int PEN_THICKNESS_IN_PIXLES = 3;
        static void Main(string[] args)
        {

            // Prompt the user to input the type of algorithm we will be using. 1 for Binary 2 for sidewinder
            System.Console.WriteLine("Please tell me what type of algorithm you want to use. (1 - Binary 2 - Sidewinder)");
            int algorithmType;

            // Create the base grid
            IGrid grid = new Grid.Grid(ROWS, COLUMNS);
            // Determine and create the type of algorithm that will be used to generate the rooms
            IMazeAlgorithm currentAlgorithm = null;
            do
            {
                // Get the type of algorithm that the user wants to use
                algorithmType = Convert.ToInt32(System.Console.ReadLine());

                switch (algorithmType)
                {
                    case 1:
                        currentAlgorithm = new Binary();
                        break;

                    case 2:
                        currentAlgorithm = new Sidewinder();
                        break;

                    default:
                        System.Console.WriteLine("Can't find this algorithm. Please choose a valid one. (1 - Binary 2 - Sidewinder)");
                        break;
                }
            } while (algorithmType > 2 || algorithmType < 1);
           
            // Create the distance tracker
            IDistanceAlgorithm solver = new Rectangular();

            // Generate the maze
            MazeGenerator.Generator generator = new MazeGenerator.Generator(grid, currentAlgorithm, solver);
            // Apply the algorithm to the generated maze
            generator.ApplyAlgorithm(); 
            int maxDistance = generator.SolveMaze(new GridPosition(0, 0));

            // create the .png with WIDTH_IN_PIXLES width and HEITH_IN_PIXELS height
            Bitmap gridPng = new Bitmap(WIDTH_IN_PIXLES, HEITH_IN_PIXLES); 
            Graphics tool = Graphics.FromImage(gridPng);
            Pen blackPen = new Pen(Color.Black, PEN_THICKNESS_IN_PIXLES);

            // create a list of rooms from the generated grid
            List<Room> rooms = grid.GetRooms(); 

            int cellWidth = WIDTH_IN_PIXLES / COLUMNS;
            int cellHeigth = HEITH_IN_PIXLES / ROWS;

            // Draw a line if there is no room in any direction. This was generated according to the roomstoconnectwith that was generated.
            foreach (Room room in rooms)
            {
                int xOfUpperLeft = room.column * cellWidth;
                int yOfUpperLeft = room.row * cellHeigth;
                // adding cellwidth shifts the position to the right
                int xOfLowerRight = (room.column * cellWidth) + cellWidth; 
                int yOfLowerRight = (room.row * cellHeigth) + cellHeigth;

                if (!room.Neighbors().Contains(Direction.NORTH))
                {
                    tool.DrawLine(blackPen, xOfUpperLeft, yOfUpperLeft, xOfLowerRight, yOfUpperLeft);
                }

                if (!room.Neighbors().Contains(Direction.WEST))
                {
                    tool.DrawLine(blackPen, xOfUpperLeft, yOfUpperLeft, xOfUpperLeft, yOfLowerRight);
                }

                if(!room.Neighbors().Contains(Direction.EAST))
                {
                    tool.DrawLine(blackPen, xOfLowerRight, yOfUpperLeft, xOfLowerRight, yOfLowerRight);
                }

                if(!room.Neighbors().Contains(Direction.SOUTH))
                {
                    tool.DrawLine(blackPen, xOfUpperLeft, yOfLowerRight, xOfLowerRight, yOfLowerRight);
                }


                double intensity = ((double)maxDistance - (double)room.distance) / ((double)maxDistance);
                double dark = Math.Round((255d * intensity));
                double bright = 128d + Math.Round(127d * intensity);

                Color roomColor = Color.FromArgb((int)dark, (int)bright, (int)dark);

                Brush roomColorBrush = new SolidBrush(roomColor);

                tool.FillRectangle(roomColorBrush, xOfUpperLeft, yOfUpperLeft, cellWidth, cellHeigth);
                
            }

            gridPng.Save("Hello.png");
            blackPen.Dispose();
            tool.Dispose();
            gridPng.Dispose();
        }
    }
}
