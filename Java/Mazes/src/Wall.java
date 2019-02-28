/**
 * Helper class to describe a wall
 */
class Wall {
    // The Wall characteristics
    int xCoor, yCoor; // Location
    boolean horz; // Orientation

    /**
     * Create a wall object
     * @param xcoord the x-coordinate for the wall
     * @param ycoord the y-coordinate for the wall
     * @param horizontal true, if the wall extends to the right of the point, false if it extends down
     */
    Wall(int xcoord, int ycoord, boolean horizontal) {
        if(xcoord < 0 || ycoord < 0) {
            throw new IllegalArgumentException("Negative values not supported");
        }
        xCoor = xcoord;
        yCoor = ycoord;
        horz = horizontal;
    }

    /**
     * Override equals for use in the map
     * @param object The object to be compared
     * @return true, if the objects are equal
     */
    @Override
    public boolean equals(Object object) {
        if (object instanceof Wall) {
            Wall other = (Wall) object;
            return this.xCoor == other.xCoor && this.yCoor == other.yCoor && this.horz == other.horz;
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
            return 1 + 3 * xCoor + 97 * yCoor;
        } else {
            return 3 * xCoor + 97 * yCoor;
        }
    }

}
