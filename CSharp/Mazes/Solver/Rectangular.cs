using Grid;
using System;
using System.Collections.Generic;

namespace DistanceAlgorithms
{
    public class Rectangular : IDistanceAlgorithm
    {
        public int GetDistances(IGrid grid, GridPosition startingCell)
        {
            Stack<Room> roomsToVisit = new Stack<Room>();

            Room startingRoom = grid[startingCell.row, startingCell.column];
            startingRoom.distance = 0;
            roomsToVisit.Push(startingRoom);

            int maxDistance = 0;
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

                        maxDistance = Math.Max(maxDistance, neighbor.distance);
                        roomsToVisit.Push(neighbor);
                    }
                }
            }

            return maxDistance;
        }
    }
}
