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
        setPreferredSize(new Dimension((width * SIZE) + (2 * BORDER) + WALL,
                (height * SIZE) + (2 * BORDER) + WALL));
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

        myMaze.maze1();
        myMaze1.maze2();
    }

    /**
     * Add a vertical wall one cell long to the maze
     *
     * @param xOffset The horizontal offset for the wall
     * @param yOffset = The vertical offset for the wall
     */
    private void addVerticalWall(int xOffset, int yOffset) {
        if (xOffset > mazeWidth || yOffset + 1 > mazeHeight) {
            throw new IllegalArgumentException("Wall exceeds maze boundary");
        }
        walls.add(new Wall(xOffset, yOffset, false));
    }

    /**
     * Add a horizontal wall one cell long to the maze.
     *
     * @param xOffset The horizontal offset for the wall
     * @param yOffset The vertical offset for the wall
     */
    private void addHorizontalWall(int xOffset, int yOffset) {
        if (xOffset + 1 > mazeWidth || yOffset > mazeHeight) {
            throw new IllegalArgumentException("Wall exceeds maze boundary");
        }
        walls.add(new Wall(xOffset, yOffset, true));
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

    /**
     * This algorithm is based on a Point(x,y) system for determining maze layout. It does not uses Cells.
     * It randomly chooses points from a bag of "setPoints" which already have been connected to another point.
     * It then chooses from a "loose point" adjacent to the current point from points stored in an array and randomly
     * draws walls based on directional availability of that point. With the current structure, this maze generator
     * makes basic mazes whereas the solution is typically a diagonal line from the starting point in the
     * upper right to the finish in the lower right. More tweaking is needed in this algorithm to
     * create a more challenging maze layout.
     */
    void maze1() {
        /*
         setPoints are points from which a wall has already been drawn before
         and where a new wall can be added to a loose point
          */
        ArrayList<Point> setPoints = new ArrayList<>();

        // Run a loop to fill the array with source points
        int counterY = 0;
        while (counterY <= mazeHeight) {
            // Add the points that make up the upper and lower walls
            if (counterY == 0 || counterY == mazeHeight) {
                for (int i = 0; i <= mazeWidth; i++) {
                    setPoints.add(new Point(i, counterY));
                }
            } else { // Fills in the points along the edges
                setPoints.add(new Point(0, counterY));
                setPoints.add(new Point(mazeWidth, counterY));
            }
            counterY++;
        }

        // loosePoints are points which have not been yet connected to another point
        ArrayList<Point> loosePoints = new ArrayList<>();

        // Run a loop to fill the loose array with the remaining points
        counterY = 1;
        while (counterY < mazeHeight) {
            for (int x = 1; x < mazeWidth; x++) {
                loosePoints.add(new Point(x, counterY));
            }
            counterY++;
        }

        // ------------------ START MAZE GENERATION ------------------------//

        // Loop through the maze and add walls until the loose points are all gone
        Random rand = new Random();

        while (loosePoints.size() > 0) {

            // Pick a random set point to draw a wall from
            Point currentPoint = setPoints.get(rand.nextInt(setPoints.size()));

            // Create 4 "check" points to compare to the current source point
            Point checkUp = new Point((int) (currentPoint.getX()), (int) currentPoint.getY() - 1);
            Point checkDown = new Point((int) (currentPoint.getX()), (int) currentPoint.getY() + 1);
            Point checkLeft = new Point((int) (currentPoint.getX() - 1), (int) currentPoint.getY());
            Point checkRight = new Point((int) (currentPoint.getX() + 1), (int) currentPoint.getY());

            // Argument to determine whether to remove the current set point from the array of source points
            boolean removePoint = false;

            // The chosen direction to travel, defaults to 0;
            int direction = 0;

            // Stores the available directions/adjacent points available to the set point
            ArrayList<Integer> availableDirection = new ArrayList<>();

            /*
            For every point in the loose array, if the checked point matches a value in the array,
            add that direction to the direction array
             */
            for (Point point : loosePoints) {
                if (point.equals(checkUp)) {
                    availableDirection.add(1);
                } else if (point.equals(checkDown)) {
                    availableDirection.add(2);
                } else if (point.equals(checkLeft)) {
                    availableDirection.add(3);
                } else if (point.equals(checkRight)) {
                    availableDirection.add(4);
                }
            }

            // If there is no adjacent loose point, remove the point from the set list
            if (availableDirection.size() == 0) {
                removePoint = true;
            } else if (availableDirection.size() == 1) { // If there is only 1 direction to travel,
                // add a wall in that direction and remove the set point from the source array
                removePoint = true;
                direction = availableDirection.get(0);
            } else {
                // If there is more than 1 adjacent point, randomly pick a direction
                direction = availableDirection.get((int) (Math.random() * availableDirection.size()));
            }

            // Based on the chosen direction, draw a wall
            //TODO: Create method to clean up the repeated code here
            if (direction == 1) { // DRAW UP
                addVerticalWall((int) currentPoint.getX(), (int) currentPoint.getY() - 1);
                loosePoints.remove(checkUp);
                setPoints.add(checkUp);
            } else if (direction == 2) {  // DRAW DOWN
                addVerticalWall((int) currentPoint.getX(), (int) currentPoint.getY());
                loosePoints.remove(checkDown);
                setPoints.add(checkDown);
            } else if (direction == 3) {  // DRAW LEFT
                addHorizontalWall((int) currentPoint.getX() - 1, (int) currentPoint.getY());
                loosePoints.remove(checkLeft);
                setPoints.add(checkLeft);
            } else if (direction == 4) { //DRAW RIGHT
                addHorizontalWall((int) currentPoint.getX(), (int) currentPoint.getY());
                loosePoints.remove(checkRight);
                setPoints.add(checkRight);
            }

            // If the source point has 0 or 1 adjacent points, remove it from the array
            if (removePoint) {
                setPoints.remove(currentPoint);
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

        // Create a storage of cells to use for recursive path-finding
        Stack<Cell> stack = new Stack<>();
        Cell currentCell = cellGrid.get(cellGrid.size() - 1);

        // In each cell, populate which directions are available for path-finding
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

                //TODO: Create another method to handle checking nextCell to remove repetition

                if (direction == 1) { // DIRECTION UP
                    int currentXCoor = currentCell.getxCoor();
                    int currentYCoor = currentCell.getyCoor() - 1;
                    Cell nextCell = null;
                    for (Cell cell : cellGrid) { // Search the cellGrid for a matching neighbor cell
                        if (currentXCoor == cell.getxCoor() && currentYCoor == cell.getyCoor()) {
                            nextCell = cell;
                            break;
                        }
                    }
                    assert nextCell != null;
                    /*
                    If the next cell has been visited, set the current cell as visited to end the path
                    and remove that direction from the current cell. Also, add the previous Cell to the
                    stack for recursive path-finding. Remove the wall between the cells and continue to next
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
                } else if (direction == 2) { // DIRECTION DOWN
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
                } else if (direction == 3) { // DIRECTION LEFT
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
                } else if (direction == 4) { // DIRECTION RIGHT
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
            } else { // When the path-finding comes to a dead end, go back one Cell
                currentCell.setVisited();
                currentCell = stack.pop();
            }
        } while (!stack.isEmpty());

        display();
    }
}
