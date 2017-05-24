using Grid;
using System;
using System.Collections.Generic;

namespace Solver
{
    public class DijkstraSolver : ISolver
    {
        public void Solve(IGrid gridToSolve, GridPosition startingCell)
        {
            Stack<Room> roomsToVisit = new Stack<Room>();

            Room startingRoom = gridToSolve[startingCell.row, startingCell.column];
            startingRoom.distance = 0;
            roomsToVisit.Push(startingRoom);

            while(roomsToVisit.Count != 0)
            {
                Room currentRoom = roomsToVisit.Pop();
                currentRoom.visited = true;

                List<Room> neighbors = currentRoom.NeighborsAsRooms();

                foreach(Room neighbor in neighbors)
                {
                    if(!neighbor.visited)
                    {
                        neighbor.distance = currentRoom.distance + 1;
                        roomsToVisit.Push(neighbor);
                    }
                }
            }
        }
    }
}
