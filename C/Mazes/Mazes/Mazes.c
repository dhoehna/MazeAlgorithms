
typedef struct
{
	int NORTH : 1;
	int SOUTH : 1;
	int EAST : 1;
	int WEST : 1;
} directions;

struct cell
{
	struct cell* NorthNeighbor;
	struct cell* SouthNeighbor;
	struct cell* EastNeighbor;
	struct cell* WestNeighbor;

};



main()
{
	//DOn't really...Wel, I don't.
	//Well, let's get started shall we?
	//WHat do we need first?  Cells, the algorithm, holding the cells.
	//But we don't have poly morphism.  THis will be fun.
	//Like.  This feels werid, even though the syntax is similar.
	//Let's start.
	//I know hwo to think about programming in and OO language, but not C.
	//Just start.

	//I need cells.

	//So a struct.
/*
	So, I have a cell.  What does a cell have?  0 - 3 walls.  Or, 1-4 exits.  Or neighbors.
	4 directions.  NORTH, SOUTH, EAST, WEST.
	I can use a bit flag for that.

	let's make it so a cell knows which neighbors it can reach.
*/
}

