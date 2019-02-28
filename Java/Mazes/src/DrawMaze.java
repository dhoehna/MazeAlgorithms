import java.awt.BasicStroke;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import java.util.Stack;

import javax.swing.JFrame;
import javax.swing.JPanel;

public class DrawMaze extends JPanel {

    /**
     * The width of the maze halls, a constant
     */
    private static final int SIZE = 15;
    /**
     * The thickness of the maze walls, a constant
     */
    private static final int WALL = 2;
    /**
     * The thickness of the border around the maze, a constant
     */
    private static final int BORDER = 5;
    /**
     * The width of the maze given in the constructor
     */
    private final int mazeWidth;
    /**
     * The height of the maze given in the constructor
     */
    private final int mazeHeight;
    // storage for the walls that are added
    private final Set<Wall> walls;

    /**
     * Construct a simple maze
     *
     * @param width  The width of the maze in "cells"
     * @param height The height of the maze in "cells"
     */
    private DrawMaze(int width, int height) {
        mazeWidth = width;
        mazeHeight = height;
        setPreferredSize(new Dimension(width * SIZE + 2 * BORDER + WALL,
                height * SIZE + 2 * BORDER + WALL));
        walls = new HashSet<>();
    }

    /**
     * Sample application method, showing how to use DrawMaze
     *
     * @param args The command-line arguments
     */
    public static void main(String[] args) {
        DrawMaze myMaze = new DrawMaze(75, 60);
        DrawMaze myMaze1 = new DrawMaze(75, 60);

        // myMaze.maze1();
        myMaze1.maze2();
    }

    /**
     * Add a vertical wall to the maze
     *
     * @param x   The horizontal offset for the wall
     * @param y   The vertical offset for the wall
     * @param len The length of the wall
     * @return true, if the requested wall added to the set of walls
     */
    private boolean addVerticalWall(int x, int y, int len) {
        if (x > mazeWidth || y + len > mazeHeight) throw new IllegalArgumentException("Wall exceeds maze boundary");
        boolean added = false;
        for (int i = 0; i < len; i++) {
            if (addVerticalWall(x, y + i)) added = true;
        }
        return added;
    }

    /**
     * Add a vertical wall one cell long to the maze
     *
     * @param x The horizontal offset for the wall
     * @param y = The vertical offset for the wall
     * @return true, if the requested wall added to the set of walls
     */
    private boolean addVerticalWall(int x, int y) {
        if (x > mazeWidth || y + 1 > mazeHeight) throw new IllegalArgumentException("Wall exceeds maze boundary");
        return walls.add(new Wall(x, y, false));
    }

    /**
     * Add a horizontal wall to the maze
     *
     * @param x The horizontal offset for the wall
     * @param y = The vertical offset for the wall
     * @return true, if the requested wall added to the set of walls
     */
    private boolean addHorizontalWall(int x, int y, int len) {
        if (x + len > mazeWidth || y > mazeHeight) throw new IllegalArgumentException("Wall exceeds maze boundary");
        boolean added = false;
        for (int i = 0; i < len; i++) {
            if (addHorizontalWall(x + i, y)) added = true;
        }
        return added;
    }

    /**
     * Add a horizontal wall one cell long to the maze.
     *
     * @param x The horizontal offset for the wall
     * @param y The vertical offset for the wall
     * @return True, if the requested wall added to the set of walls
     */
    private boolean addHorizontalWall(int x, int y) {
        if (x + 1 > mazeWidth || y > mazeHeight)
            throw new IllegalArgumentException("Wall exceeds maze boundary");
        return walls.add(new Wall(x, y, true));
    }

    /**
     * Display the maze in a JFrame
     */
    private void display() {
        JFrame win = new JFrame("My Maze");
        win.setLocation(25, 25);
        win.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        win.add(this);
        win.pack();
        win.setVisible(true);
    }

    /**
     * Paint the maze component
     *
     * @param g The graphics object for rendering
     */
    @Override
    public void paintComponent(Graphics g) {
        Graphics2D g2 = (Graphics2D) g;
        g2.setStroke(new BasicStroke(WALL));
        int[] xs = {BORDER + WALL, BORDER, BORDER, BORDER + (mazeWidth - 1) * SIZE + WALL};
        int[] ys = {BORDER, BORDER, BORDER + mazeHeight * SIZE, BORDER + mazeHeight * SIZE};
        g2.drawPolyline(xs, ys, 4);
        int[] xs2 = {BORDER + SIZE - WALL, BORDER + mazeWidth * SIZE, BORDER + mazeWidth * SIZE, BORDER + mazeWidth * SIZE - WALL};
        g2.drawPolyline(xs2, ys, 4);

        for (Wall wall : walls) {
            drawWall(g2, wall);
        }
    }

    /**
     * Helper method to draw a horizontal wall
     */
    private void drawWall(Graphics g, Wall wall) {
        int x = wall.xCoor;
        int y = wall.yCoor;
        if (wall.horz) {
            g.drawLine(BORDER + x * SIZE, BORDER + y * SIZE, BORDER + (x + 1) * SIZE, BORDER + y * SIZE);
        } else {
            g.drawLine(BORDER + x * SIZE, BORDER + y * SIZE, BORDER + x * SIZE, BORDER + (y + 1) * SIZE);
        }
    }

    /**
     * Access to the set of walls
     *
     * @return the set of walls
     */
    public Set<Wall> getWallSet() {
        return walls;
    }

    void maze1() {
        ArrayList<Point> source = new ArrayList<>();
        ArrayList<Point> loose = new ArrayList<>();

        // Run a loop to fill the array with source points
        int counterY = 0;
        while (counterY <= mazeHeight) {
            // Add the points that make up the upper and lower walls
            if (counterY == 0 || counterY == mazeHeight) {
                for (int i = 0; i <= mazeWidth; i++) {
                    source.add(new Point(i, counterY));
                }
            } else { // Fills in the points along the edges
                source.add(new Point(0, counterY));
                source.add(new Point(mazeWidth, counterY));
            }
            counterY++;
        }

        // Run a loop to fill the loose array with the remaining points
        counterY = 1;
        while (counterY < mazeHeight) {
            for (int x = 1; x < mazeWidth; x++) {
                loose.add(new Point(x, counterY));
            }
            counterY++;
        }

        // ------------------ START MAZE GENERATION ------------------------//

        // Loop through the maze and add walls until the loose points are all gone
        while (loose.size() > 0) {
            Random rand = new Random();

            // Pick a random source point to draw a wall from
            Point sourcePoint = source.get(rand.nextInt(source.size()));

            // Create 4 "check" points to compare to the current source point
            Point checkUp = new Point((int) (sourcePoint.getX()), (int) sourcePoint.getY() - 1);
            Point checkDown = new Point((int) (sourcePoint.getX()), (int) sourcePoint.getY() + 1);
            Point checkLeft = new Point((int) (sourcePoint.getX() - 1), (int) sourcePoint.getY());
            Point checkRight = new Point((int) (sourcePoint.getX() + 1), (int) sourcePoint.getY());

            // Argument to determine whether to remove the source point
            boolean removePoint = false;

            // The chosen direction to travel, defaults to 0;
            int direction = 0;

            // Stores the available populateAvailableDirections/adjacent points available to the source point
            ArrayList<Integer> availableDirection = new ArrayList<>();

            /*
            For every point in the loose array, if the checked point matches a value in the array,
            add that direction to the direction array
             */
            for (Point p : loose) {
                if (p.equals(checkUp)) {
                    availableDirection.add(1);
                } else if (p.equals(checkDown)) {
                    availableDirection.add(2);
                } else if (p.equals(checkLeft)) {
                    availableDirection.add(3);
                } else if (p.equals(checkRight)) {
                    availableDirection.add(4);
                }
            }

            // If there is no adjacent loose point, remove the point from the source list
            if (availableDirection.size() == 0) {
                removePoint = true;
            } else if (availableDirection.size() == 1) { // If there is only 1 direction to travel,
                // add a wall in that direction and remove the source point from the source array
                removePoint = true;
                direction = availableDirection.get(0);
            } else {
                // If there is more than 1 adjacent point, randomly pick a direction
                direction = availableDirection.get((int) (Math.random() * availableDirection.size()));
            }

            // Based on the chosen direction, draw a wall
            if (direction == 1) { // DRAW UP
                this.addVerticalWall((int) sourcePoint.getX(), (int) sourcePoint.getY() - 1, 1);
                loose.remove(checkUp);
                source.add(checkUp);
            } else if (direction == 2) {  // DRAW DOWN
                this.addVerticalWall((int) sourcePoint.getX(), (int) sourcePoint.getY(), 1);
                loose.remove(checkDown);
                source.add(checkDown);
            } else if (direction == 3) {  // DRAW LEFT
                this.addHorizontalWall((int) sourcePoint.getX() - 1, (int) sourcePoint.getY(), 1);
                loose.remove(checkLeft);
                source.add(checkLeft);
            } else if (direction == 4) { //DRAW RIGHT
                this.addHorizontalWall((int) sourcePoint.getX(), (int) sourcePoint.getY(), 1);
                loose.remove(checkRight);
                source.add(checkRight);
            }

            // If the source point has 0 or 1 adjacent points, remove it from the array
            if (removePoint) {
                source.remove(sourcePoint);
            }
        }
        display();
    }

    /**
     * Algorithm to generate a maze via Depth-First Search (DFS) until all cells have been visited This maze is created
     * by generating a wall filled maze and then removing walls in a given path
     */
    private void maze2() throws NullPointerException {

        ArrayList<Cell> cellGrid = new ArrayList<>();

        // Generate a wall filled maze
        for (int i = 0; i < mazeWidth; i++) {
            for (int j = 0; j < mazeHeight; j++) {

                addVerticalWall(i, j);
                addHorizontalWall(i, j);

                cellGrid.add(new Cell(i, j));
            }
        }

        // Remove the wall on the opening
        walls.remove(new Wall(0, 0, true));

        // Create the stack to use for recursive pathfinding
        Stack<Cell> stack = new Stack<>();
        // Start at the last cell which will be the finish
        Cell currentCell = cellGrid.get(cellGrid.size() - 1);

        // In each cell, populate which populateAvailableDirections are available
        for (Cell cell : cellGrid) {
            cell.populateAvailableDirections(mazeHeight, mazeWidth);
        }

        // Start the maze generation loop
        do {
            int direction;
            Random rand = new Random();

            /*
            If the current cell has moves available, adds them to the availableMoves list and randomly
            choose a direction
             */
            if (currentCell.hasAvailableMoves()) {
//                ArrayList<Integer> availableMoves = current.getAvailableDirections();
//                direction = availableMoves.get(rand.nextInt(availableMoves.size()));
                direction = currentCell.getAvailableDirections().get(rand.nextInt(currentCell.getAvailableDirections().size()));

                //TODO: Create another method to handle Cell checking and checking next cell to remove repetition

                if (direction == 1) {
                    int currentXCoor = currentCell.getxCoor();
                    int currentYCoor = currentCell.getyCoor() - 1;
                    Cell nextCell = null;
                    for (Cell cell : cellGrid) {
                        if (currentXCoor == cell.getxCoor() && currentYCoor == cell.getyCoor()) {
                            nextCell = cell;
                            break;
                        }
                    }
                    assert nextCell != null;
                    /*
                    If the next cell has been visited, set the current cell as visited to end the path
                    and remove that direction from the current cell.
                     */
                    if (nextCell.isVisited()) {
                        currentCell.setVisited();
                        currentCell.removeDirection(direction);
                        stack.add(currentCell);
                        walls.remove(new Wall(currentCell.getxCoor(), currentCell.getyCoor(), true));
                        currentCell = nextCell;
                    } else {
                        currentCell.removeDirection(direction);
                    }
                } else if (direction == 2) {
                    int gridX = currentCell.getxCoor();
                    int gridY = currentCell.getyCoor() + 1;
                    Cell check = null;
                    for (Cell c : cellGrid) {
                        if (gridX == c.getxCoor() && gridY == c.getyCoor()) {
                            check = c;
                            break;
                        }
                    }
                    assert check != null;
                    if (check.isVisited()) {
                        currentCell.setVisited();
                        currentCell.removeDirection(direction);
                        stack.add(currentCell);
                        walls.remove(new Wall(currentCell.getxCoor(), currentCell.getyCoor() + 1, true));
                        currentCell = check;
                    } else {
                        currentCell.removeDirection(direction);
                    }
                } else if (direction == 3) {
                    int gridX = currentCell.getxCoor() - 1;
                    int gridY = currentCell.getyCoor();
                    Cell check = null;
                    for (Cell c : cellGrid) {
                        if (gridX == c.getxCoor() && gridY == c.getyCoor()) {
                            check = c;
                            break;
                        }
                    }
                    assert check != null;
                    if (check.isVisited()) {
                        currentCell.setVisited();
                        currentCell.removeDirection(direction);
                        stack.add(currentCell);
                        walls.remove(new Wall(currentCell.getxCoor(), currentCell.getyCoor(), false));
                        currentCell = check;
                    } else {
                        currentCell.removeDirection(direction);
                    }
                } else if (direction == 4) {
                    int gridX = currentCell.getxCoor() + 1;
                    int gridY = currentCell.getyCoor();
                    Cell check = null;
                    for (Cell c : cellGrid) {
                        if (gridX == c.getxCoor() && gridY == c.getyCoor()) {
                            check = c;
                            break;
                        }
                    }
                    assert check != null;
                    if (check.isVisited()) {
                        currentCell.setVisited();
                        currentCell.removeDirection(direction);
                        stack.add(currentCell);
                        walls.remove(new Wall(currentCell.getxCoor() + 1, currentCell.getyCoor(), false));
                        currentCell = check;
                    } else {
                        currentCell.removeDirection(direction);
                    }
                }
            } else {
                currentCell.setVisited();
                currentCell = stack.pop();
            }
        } while (!stack.isEmpty());

        display();
    }
}
