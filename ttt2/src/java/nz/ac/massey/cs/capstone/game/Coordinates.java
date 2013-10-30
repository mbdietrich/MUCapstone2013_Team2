/*
 * @author Ryan
 * This class can be used to store the coordinates for the inner and top games.
 */
package nz.ac.massey.cs.capstone.game;

public class Coordinates 
{
    int outerX = 0;
    int outerY = 0;
    int innerX = 0;
    int innerY = 0;

    /**
     * Constructor.
     * Sets all the coordinates.
     * @param outerX The superGame X coordinate.
     * @param outerY The superGame y coordinate.
     * @param innerX The subGame X coordinate.
     * @param innerY The subGame Y coordinate.
     */
    public Coordinates (int outerX, int outerY, int innerX, int innerY)
    {
        this.outerX = outerX;
        this.outerY = outerY;
        this.innerX = innerX;
        this.innerY = innerY;
    }

    public void setOuterX(int outerX)
    {
        this.outerX = outerX;
    }

    public void setOuterY(int outerY)
    {
        this.outerY = outerY;
    }

    public void setInnerX(int innerX)
    {
        this.innerX = innerX;
    }

    public void setInnerY(int innerY)
    {
        this.innerY = innerY;
    }

    public int getOuterX()
    {
        return outerX;
    }

    public int getOuterY()
    {
        return outerY;
    }

    public int getInnerX()
    {
        return innerX;
    }

    public int getInnerY()
    {
        return innerY;
    }
    public String getAllCoords()
    {
        return Integer.toString(outerX) + Integer.toString(outerY) + Integer.toString(innerX) + Integer.toString(innerY);
    }
}