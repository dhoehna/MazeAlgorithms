using Grid;
using System;
using System.Collections.Generic;
using System.Text;

namespace DistanceAlgorithms
{
    public interface IDistanceAlgorithm
    {
        int GetDistances(IGrid grid, GridPosition startingCell);
    }
}
