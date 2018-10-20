#include <stdio.h>
#include <stdlib.h>
#include <time.h>


typedef struct
{
	int NORTH : 1;
	int SOUTH : 1;
	int EAST : 1;
	int WEST : 1;
} directions;

enum direction
{
	NORTH,
	SOUTH,
	EAST,
	WEST
};

struct Point
{
	unsigned int xPosition;
	unsigned int yPosition;
};

/*
A cell only has a neighbor if there is not a wall between the two rooms.
*/
struct Cell
{
	struct Cell* northNeighbor;
	struct Cell* southNeighbor;
	struct Cell* eastNeighbor;
	struct Cell* westNeighbor;
	struct Point cellPosition;
};

struct Maze
{
	unsigned int width;
	unsigned int heigth;
	struct Cell startingCell;
};

static unsigned int maxWidth;
static unsigned int maxHeigth;

void MakeMaze(struct Cell* currentCell);

/*
void MakeNeighbor(struct Cell* first, struct Cell* second, enum direction directionFromFirstToSecond);
*/

main()
{
	maxHeigth = 10;
	maxWidth = 10;

	struct Point startingPoint;
	startingPoint.xPosition = 0;
	startingPoint.yPosition = 0;

	struct Cell startingCell;
	startingCell.cellPosition = startingPoint;

	struct Maze myMaze;
	myMaze.heigth = maxHeigth;
	myMaze.width = maxWidth;
	myMaze.startingCell = startingCell;

	srand(time(NULL));
	MakeMaze(&myMaze.startingCell);

	/*
	Alright.  So.  Algorithm time.  I need to take the starting cell and figure out which direction to go.
	Either north or east.  Here is an interesting thing.
	I could just go cell to cel...Nooo. I can't.  I can't because this is a list.  I have to travel from one cell to another.

	Okay.  So, start at the starting location, choose either north or east.

	What I have now won't work with the binary algorithm.  I don't know.  Let's try it.
	*/
}

void MakeMaze(struct Cell* currentCell)
{
	
	struct Cell* nextCell = (struct Cell*) malloc(sizeof(struct Cell));
	struct Point nextPoint;
	nextCell->eastNeighbor = NULL;
	nextCell->northNeighbor = NULL;
	nextCell->southNeighbor = NULL;
	nextCell->westNeighbor = NULL;
	
	//In the corner.
	if (currentCell->cellPosition.xPosition == maxWidth && currentCell->cellPosition.yPosition == 0)
	{
		nextPoint.xPosition = currentCell->cellPosition.xPosition;
		nextPoint.yPosition = (currentCell->cellPosition.yPosition) + 1;
	}
	else if (currentCell->cellPosition.yPosition == 0) // on the north wall
	{

	}
	else if (currentCell->cellPosition.xPosition == maxWidth) // on the east wall
	{

	}
	else
	{

	}

}
