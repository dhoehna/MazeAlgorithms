/**
 * Helper class to describe a wall
 */
class Wall {
    // The Wall characteristics
    private int x, y; // Location
    private boolean horz; // Orientation

    /**
     * Create a wall object
     * @param xcoord the x-coordinate for the wall
     * @param ycoord the y-coordinate for the wall
     * @param horizontal true, if the wall extends to the right of the point, false if it extends down
     */
    public Wall(int xcoord, int ycoord, boolean horizontal) {
        if(xcoord < 0 || ycoord < 0) {
            throw new IllegalArgumentException("Negative values not supported");
        }
        x = xcoord;
        y = ycoord;
        horz = horizontal;
    }

    /**
     * Override equals for use in the map
     * @param o The object to be compared
     * @return true, if the objects are equal
     */
    @Override
    public boolean equals(Object o) {
        if(o instanceof Wall) {
            Wall other = (Wall) o;
            return this.x == other.x && this.y == other.y && this.horz == other.horz;
        } else {
            return false;
        }
    }

    /**
     * Override hashCode for use in the map
     * @return A hashcode for use in the map
     */
    @Override
    public int hashCode() {
        if(horz) {
            return 1 + 3 * x + 97 * y;
        } else {
            return 3 * x + 97 * y;
        }
    }

}
