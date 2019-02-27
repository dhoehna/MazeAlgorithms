import java.util.ArrayList;

class Cell {

    private boolean visited;
    private final int x;
    private final int y;
    private final ArrayList<Integer> availableDirections = new ArrayList<>();

    /**
     * Default Constructor
     * @param x The left/right coordinate
     * @param y The up/down coordinate
     */
    Cell(int x, int y) {
        this.x = x;
        this.y = y;
    }

    boolean isVisited() {
        return !visited;
    }

    int getX() {
        return x;
    }

    int getY() {
        return y;
    }

    void setVisited() {
        this.visited = true;
    }

    /**
     * Checks that the number of available moves is greater than 0
     * @return True is available directions is greater than 0
     */
    boolean hasAvailableMoves() {
        return availableDirections.size() > 0;
    }

    /**
     * Checks the cell for available directions. If the Cell is along the border, it removes the
     * edge as an available space
     * @param height The height of the grid
     * @param width The width of the grid
     */
    void directions(int height, int width) {
        // Check upward movement
        if(y - 1 >= 0) {
            availableDirections.add(1);
        }
        // Check downward movement
        if(y + 1 < height) {
            availableDirections.add(2);
        }
        // Check left side
        if(x - 1 >= 0) {
            availableDirections.add(3);
        }
        // Check right side
        if(x + 1 < width) {
            availableDirections.add(4);
        }
    }

    ArrayList<Integer> getAvailableDirections() {
        return availableDirections;
    }
}