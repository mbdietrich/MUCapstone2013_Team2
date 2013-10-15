/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import java.util.ArrayList;

/**
 *
 * @author Ryan
 */
public class SubGameTest {
    
    public SubGameTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Tests that the setGamePiece() function by placing pieces on the board,
     * then comparing the board to what it should be.
     */
    @Test
    public void testSetGamePiece() {
        SubGame subgame = new SubGame();
        subgame.setGamePiece(1, 1, 1);
        subgame.setGamePiece(0, 0, 2);
        int[][] result = subgame.getBoard();
        int[][] expResult = new int[][]{{2,0,0},{0,1,0},{0,0,0}};
        assertArrayEquals(result, expResult);
    }

    /**
     * Test of getGamePiece method, of class SubGame.
     */
    @Test
    public void testGetGamePiece() {
        SubGame subgame = new SubGame();
        ArrayList result = new ArrayList();
        ArrayList expResult = new ArrayList();
        subgame.setBoard(new int[][]{{2,1,0},{1,1,0},{2,2,1}});

        result.add(subgame.getGamePiece(0, 0));
        expResult.add(2);
        result.add(subgame.getGamePiece(1, 1));
        expResult.add(1);
        result.add(subgame.getGamePiece(2, 2));
        expResult.add(1);

        assertEquals(result, expResult);
    }

    /**
     * Test of getBoard method, of class SubGame.
     */
    @Test
    public void testGetBoard() {
        SubGame subgame = new SubGame();
        int[][] expResult = new int[][]{{1,1,1},{0,0,0},{0,0,0}};
        subgame.setBoard(expResult);
        int[][] result = subgame.getBoard();
        assertArrayEquals(result, expResult);
    }

    /**
     * Tests setBoard() by setting a specific board, then checking to see if
     * that board is returned.
     */
    @Test
    public void testSetBoard1() {
        SubGame subgame = new SubGame();
        int[][] board = new int[][]{{1,0,1},{0,1,0},{2,2,2}};
        subgame.setBoard(board);
        assertArrayEquals(board, subgame.getBoard());
    }
    
    /**
     * Test for seeing if setBoard() also checks for a winner.
     */
    @Test
    public void testSetBoard2()
    {
        SubGame subgame = new SubGame();
        subgame.setBoard(new int[][]{{1,1,1},{2,2,1},{2,1,2}});
        int result = subgame.getStatus();
        assertEquals(1, result);
    }

    /**
     * Test for seeing if setBoard() also checks for a draw.
     */
    @Test
    public void testSetBoard3()
    {
        SubGame subgame = new SubGame();
        subgame.setBoard(new int[][]{{2,1,2},{1,1,2},{1,2,1}});
        int result = subgame.getStatus();
        assertEquals(3, result);
    }

    /**
     * Tests that getStatus() returns the correct status of the subgame.
     */
    @Test
    public void testGetStatus1() {
        SubGame subgame = new SubGame();
        int result = subgame.getStatus();
        assertEquals(0, result);
    }
    
    /**
     * Tests that getStatus() recognizes and returns a winner.
     */
    @Test
    public void testGetStatus2()
    {
        SubGame subgame = new SubGame();

        subgame.setGamePiece(0, 0, 1);
        subgame.setGamePiece(1, 0, 1);
        subgame.setGamePiece(2, 0, 1);
        subgame.setGamePiece(0, 1, 2);
        subgame.setGamePiece(1, 1, 2);

        int result = subgame.getStatus();
        assertEquals(1, result);
    }

    /**
     * tests that getStatus() recognizes and returns a draw.
     */
    @Test
    public void testGetStatus3()
    {
        SubGame subgame = new SubGame();

        subgame.setGamePiece(0, 0, 2);
        subgame.setGamePiece(0, 1, 1);
        subgame.setGamePiece(0, 2, 2);
        subgame.setGamePiece(1, 0, 1);
        subgame.setGamePiece(1, 1, 1);
        subgame.setGamePiece(1, 2, 2);
        subgame.setGamePiece(2, 0, 1);
        subgame.setGamePiece(2, 1, 2);
        subgame.setGamePiece(2, 2, 1);

        int result = subgame.getStatus();
        assertEquals(3, result);
    }

    /**
     * Test of setStatus method, of class SubGame.
     */
    @Test
    public void testSetStatus() 
    {
        SubGame subgame = new SubGame();
        ArrayList result = new ArrayList();
        ArrayList expResult = new ArrayList();

        result.add(subgame.getStatus());
        expResult.add(0);

        subgame.setStatus(3);
        result.add(subgame.getStatus());
        expResult.add(3);

        subgame.setStatus(1);
        result.add(subgame.getStatus());
        expResult.add(1);

        assertEquals(result,expResult);
    }
}