using Grid;
using System;
using System.Collections.Generic;
using System.Text;

namespace Solver
{
    public interface ISolver
    {
        void Solve(IGrid gridToSolve);
    }
}
