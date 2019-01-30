#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "Queue.h"
#include "png.h"


typedef struct
{
	int NORTH : 1;
	int SOUTH : 1;
	int EAST : 1;
	int WEST : 1;
} directions;

enum direction
{
	NORTH = 1 << 0,
	SOUTH = 1 << 1,
	EAST = 1 << 2,
	WEST = 1 << 3,
	NONE
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
	SIMPLEQ_ENTRY(Cell) entries;
	int spacesAwayFromStartingCell;
	//int hasBeenVisited;
};

struct Maze
{
	unsigned int width;
	unsigned int heigth;
	struct Cell startingCell;
};

static int** hasBeenLinked;

static unsigned int maxWidth;
static unsigned int maxHeigth;

void MakeMaze(struct Cell* currentCell);
enum direction GetNewNeighborDirection(struct Cell* currentCell);
void MakeNewCellWithNeighbor(enum direction directionOfNeighbor, struct Cell* currentCell, struct Cell* emptyCell);
int HasCellBeenLinked(struct Point* cellLocation);
void MarkCellAsLinked(struct Point* cellLocation);

/*
void MakeNeighbor(struct Cell* first, struct Cell* second, enum direction directionFromFirstToSecond);
*/

main()
{
	maxHeigth = 5;
	maxWidth = 5;

	hasBeenLinked = (int **)malloc(maxHeigth * sizeof(int *));

	for (int i = 0; i < maxHeigth; i++)
	{
		hasBeenLinked[i] = (int *)malloc(maxWidth * sizeof(int));
	}

	for (int currentRow = 0; currentRow < maxHeigth; currentRow++)
	{
		for (int currentColumn = 0; currentColumn < maxWidth; currentColumn++)
		{
			hasBeenLinked[currentRow][currentColumn] = 0;
		}
	}

	struct Point* startingPoint = (struct Point*) malloc(sizeof(struct Point));
	startingPoint->xPosition = 0;
	startingPoint->yPosition = 0;

	struct Cell startingCell;
	startingCell.cellPosition = startingPoint;
	startingCell.spacesAwayFromStartingCell = 0;

	struct Maze myMaze;
	myMaze.heigth = maxHeigth;
	myMaze.width = maxWidth;
	myMaze.startingCell = startingCell;


	srand(time(NULL));
	MakeMaze(&myMaze.startingCell);
}

//east and south instead.
void MakeMaze(struct Cell* currentCell)
{

	SIMPLEQ_HEAD(cellQueue, Cell) head = SIMPLEQ_HEAD_INITIALIZER(head);

	SIMPLEQ_INSERT_HEAD(&head, currentCell, entries);

	while (!SIMPLEQ_EMPTY(&head))
	{
		struct Cell* cellToLookAt = SIMPLEQ_FIRST(&head);
		SIMPLEQ_REMOVE_HEAD(&head, entries);
		enum direction directionOfNewNeighbors = GetNewNeighborDirections(cellToLookAt);

		if (directionOfNewNeighbors != NONE)
				{
					if (directionOfNewNeighbors == (EAST | SOUTH))
					{
						struct Cell* eastNeighbor = malloc(sizeof(struct Cell));
						eastNeighbor->spacesAwayFromStartingCell = cellToLookAt->spacesAwayFromStartingCell + 1;
						MakeNewCellWithNeighbor(EAST, cellToLookAt, eastNeighbor);
						SIMPLEQ_INSERT_TAIL(&head, eastNeighbor, entries);
						MarkCellAsLinked(eastNeighbor->cellPosition);

						struct Cell* southNeighbor = malloc(sizeof(struct Cell));
						southNeighbor->spacesAwayFromStartingCell = cellToLookAt->spacesAwayFromStartingCell + 1;
						MakeNewCellWithNeighbor(SOUTH, cellToLookAt, southNeighbor);
						SIMPLEQ_INSERT_TAIL(&head, southNeighbor, entries);
						MarkCellAsLinked(southNeighbor->cellPosition);
					}
					else if (directionOfNewNeighbors == EAST)
					{
						struct Cell* eastNeighbor = malloc(sizeof(struct Cell));
						eastNeighbor->spacesAwayFromStartingCell = cellToLookAt->spacesAwayFromStartingCell + 1;
						MakeNewCellWithNeighbor(EAST, cellToLookAt, eastNeighbor);
						SIMPLEQ_INSERT_TAIL(&head, eastNeighbor, entries);
						MarkCellAsLinked(eastNeighbor->cellPosition);
					}
					else if (directionOfNewNeighbors == SOUTH)
					{
						struct Cell* southNeighbor = malloc(sizeof(struct Cell));
						southNeighbor->spacesAwayFromStartingCell = cellToLookAt->spacesAwayFromStartingCell + 1;
						MakeNewCellWithNeighbor(SOUTH, cellToLookAt, southNeighbor);
						SIMPLEQ_INSERT_TAIL(&head, southNeighbor, entries);
						MarkCellAsLinked(southNeighbor->cellPosition);
					}
				}
	}
}

enum direction GetNewNeighborDirections(struct Cell* currentCell)
{
	//figure out if we can go south
	int onSouthWall = currentCell->cellPosition->yPosition == (maxHeigth - 1);
	int hasSouthBeenLinked = 1;
	if (!onSouthWall)
	{
		struct Point southNeighbor;
		southNeighbor.xPosition = currentCell->cellPosition->xPosition;
		southNeighbor.yPosition = ((currentCell->cellPosition->yPosition) + 1);
		hasSouthBeenLinked = HasCellBeenLinked(&southNeighbor);
	}

	//Gifure out if we can go east.
	int onEastWall = currentCell->cellPosition->xPosition == (maxWidth - 1);
	int hasEastBeenLinked = 1;
	if (!onEastWall)
	{
		struct Point eastNeighbor;
		eastNeighbor.xPosition = ((currentCell->cellPosition->xPosition) + 1) ;
		eastNeighbor.yPosition = currentCell->cellPosition->yPosition;
		hasEastBeenLinked = HasCellBeenLinked(&eastNeighbor);
	}

	int canGoSouth = !(onSouthWall || hasSouthBeenLinked);
	int canGoEast = !(onEastWall || hasEastBeenLinked);

	enum direction directionOfNewNeighbor = NONE;

	if (canGoEast && canGoSouth)
	{
		directionOfNewNeighbor = EAST | SOUTH;
	}
	else if (canGoEast && !canGoSouth)
	{
		directionOfNewNeighbor = EAST;
	}
	else if (canGoSouth && !canGoEast)
	{
		directionOfNewNeighbor = SOUTH;
	}
	else
	{
		directionOfNewNeighbor = NONE;
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

int HasCellBeenLinked(struct Point* cellLocation)
{
	return hasBeenLinked[cellLocation->xPosition][cellLocation->yPosition];
}

void MarkCellAsLinked(struct Point* cellLocation)
{
	hasBeenLinked[cellLocation->xPosition][cellLocation->yPosition] = 1;
}