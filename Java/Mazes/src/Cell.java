import java.util.ArrayList;

class Cell {

    private final int xCoor;
    private final int yCoor;
    private final ArrayList<Integer> availableDirections = new ArrayList<>();
    private boolean visited;

    /**
     * Default Constructor
     *
     * @param xCoor The left/right coordinate
     * @param yCoor The up/down coordinate
     */
    Cell(int xCoor, int yCoor) {
        this.xCoor = xCoor;
        this.yCoor = yCoor;
    }

    boolean isVisited() {
        return !visited;
    }

    void setVisited() {
        this.visited = true;
    }

    int getxCoor() {
        return xCoor;
    }

    int getyCoor() {
        return yCoor;
    }



    /**
     * Checks that the number of available moves to this Cell is greater than 0
     *
     * @return true when ArrayList availableDirections is greater than 0
     */
    boolean hasAvailableMoves() {
        return availableDirections.size() > 0;
    }

    /**
     * Checks the cell for available directions to move to next cell. If the Cell is along the border, it removes the
     * edge as an available space
     *
     * Integers are used to indicate directional availability in the availableDirections array.
     *
     * 1 -> UP
     * 2 -> DOWN
     * 3 -> LEFT
     * 4 -> RIGHT
     *
     * @param height The height of the grid
     * @param width  The width of the grid
     */
    // TODO: Update directions with Enum
    void populateAvailableDirections(int height, int width) {
        // Check upward movement
        if (yCoor - 1 >= 0) {
            availableDirections.add(1);
        }
        // Check downward movement
        if (yCoor + 1 < height) {
            availableDirections.add(2);
        }
        // Check left side
        if (xCoor - 1 >= 0) {
            availableDirections.add(3);
        }
        // Check right side
        if (xCoor + 1 < width) {
            availableDirections.add(4);
        }
    }

    /**
     * Removes the given direction from the availableDirections array when it exists within the array
     *
     * @param direction The direction to remove
     */
    void removeDirection(int direction) {
        if (availableDirections.contains(direction)) {
            availableDirections.remove(availableDirections.indexOf(direction));
        }
    }

    ArrayList<Integer> getAvailableDirections() {
        return availableDirections;
    }
}