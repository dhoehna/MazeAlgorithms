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
	WEST,
	NONE,
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
	struct Point* cellPosition;
	//int hasBeenVisited;
};

struct Maze
{
	unsigned int width;
	unsigned int heigth;
	struct Cell startingCell;
};

static int** hasBeenVisited;

static unsigned int maxWidth;
static unsigned int maxHeigth;

void MakeMaze(struct Cell* currentCell);
enum direction GetNewNeighborDirection(struct Cell* currentCell);
void MakeNewCellWithNeighbor(enum direction directionOfNeighbor, struct Cell* currentCell, struct Cell* emptyCell);
int HasCellBeenVisited(struct Point* cellLocation);
void MarkCallAsVisited(struct Point* cellLocation);

/*
void MakeNeighbor(struct Cell* first, struct Cell* second, enum direction directionFromFirstToSecond);
*/

main()
{
	maxHeigth = 5;
	maxWidth = 5;

	hasBeenVisited = (int **)malloc(maxHeigth * sizeof(int *));

	for (int i = 0; i < maxHeigth; i++)
	{
		(int **)malloc(maxHeigth * sizeof(int *));
	}

	for (int currentRow = 0; currentRow < maxHeigth; currentRow++)
	{
		for (int currentColumn = 0; currentColumn < maxWidth; currentColumn++)
		{
			hasBeenVisited[currentRow][currentColumn] = 0;
		}
	}

	struct Point* startingPoint = (struct Point*) malloc(sizeof(struct Point));
	startingPoint->xPosition = 0;
	startingPoint->yPosition = 0;

	struct Cell startingCell;
	startingCell.cellPosition = startingPoint;
	MarkCallAsVisited(startingPoint);

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

//east and south instead.
void MakeMaze(struct Cell* currentCell)
{
	if (HasCellBeenVisited(currentCell->cellPosition))
	{
		//Next thing is too make the end cases.  Most likely I'll add a bool to cells to see if it has been
		//visited or not.


		enum direction directionOfNewNeighbor = GetNewNeighborDirection(currentCell);

		struct Cell* nextCell = (struct Cell*) malloc(sizeof(struct Cell));

		MakeNewCellWithNeighbor(directionOfNewNeighbor, currentCell, nextCell);
		
		MarkCallAsVisited(currentCell->cellPosition);
		MakeMaze(nextCell);
	}


}

enum direction GetNewNeighborDirection(struct Cell* currentCell)
{
	enum direction directionOfNewNeighbor = 0;


	

	//Figure out direction of what direction to open the new wall.
	//In the corner.
	if (currentCell->cellPosition->xPosition == maxWidth && currentCell->cellPosition->yPosition == maxHeigth)
	{
		directionOfNewNeighbor = SOUTH;
	}
	else if ((currentCell->cellPosition->yPosition) + 1 == maxHeigth) // on the south wall
	{
		directionOfNewNeighbor = EAST;
	}
	else if ((currentCell->cellPosition->xPosition) + 1 == maxWidth) // on the east wall
	{
		directionOfNewNeighbor = SOUTH;
	}
	else
	{
		int r = rand() % 2;

		if (r == 0) // open up south
		{
			directionOfNewNeighbor = SOUTH;
		}
		else // open east
		{
			directionOfNewNeighbor = EAST;
		}
	}

	return directionOfNewNeighbor;
}

void MakeNewCellWithNeighbor(enum direction directionOfNewNeighbor, struct Cell* currentCell, struct Cell* emptyCell)
{
	emptyCell->eastNeighbor = NULL;
	emptyCell->northNeighbor = NULL;
	emptyCell->southNeighbor = NULL;
	emptyCell->westNeighbor = NULL;

	struct Point* nextPoint = (struct Point*) malloc(sizeof(struct Point));
	nextPoint->xPosition = 0;
	nextPoint->yPosition = 0;


	//Assing point and neighbors.
	if (SOUTH == directionOfNewNeighbor)
	{
		nextPoint->xPosition = currentCell->cellPosition->xPosition;
		nextPoint->yPosition = currentCell->cellPosition->yPosition + 1;

		emptyCell->cellPosition = nextPoint;

		currentCell->southNeighbor = emptyCell;
		emptyCell->northNeighbor = currentCell;
	}
	else
	{
		nextPoint->xPosition = currentCell->cellPosition->xPosition + 1;
		nextPoint->yPosition = currentCell->cellPosition->yPosition;

		emptyCell->cellPosition = nextPoint;

		currentCell->eastNeighbor = emptyCell;
		emptyCell->westNeighbor = currentCell;
	}
}

int HasCellBeenVisited(struct Point* cellLocation)
{
	return hasBeenVisited[cellLocation->xPosition][cellLocation->yPosition];
}

void MarkCallAsVisited(struct Point* cellLocation)
{
	hasBeenVisited[cellLocation->xPosition][cellLocation->yPosition] = 1;
}