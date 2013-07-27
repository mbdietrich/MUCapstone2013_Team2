/*
 * @author Ryan
 * This class can be used to store the coordinates for the inner and top games.
 */
package capstone.game;

public class Coordinates 
{
    int outerX = 0;
    int outerY = 0;
    int innerX = 0;
    int innerY = 0;
    
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
}