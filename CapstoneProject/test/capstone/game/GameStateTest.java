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
public class GameStateTest {
    
    public GameStateTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of PlacePiece method, of class GameState.
     */
    @Test
    public void testPlacePiece() {
        ArrayList results = new ArrayList();
        ArrayList expResults = new ArrayList();
        GameState state = new GameState();
        Coordinates move1 = new Coordinates(1,1,1,1);
        Coordinates move2 = new Coordinates(0,0,1,1);
        Coordinates move3 = new Coordinates(2,2,1,1);
        
        state.PlacePiece(move1, 1);
        state.PlacePiece(move2, 2);
        state.PlacePiece(move3, 1);
        
        results.add(state.GetSubBoard(1, 1)[1][1]);
        expResults.add(1);
        results.add(state.GetSubBoard(0, 0)[1][1]);
        expResults.add(2);
        results.add(state.GetSubBoard(2, 2)[1][1]);
        expResults.add(1);
        assertEquals(results, expResults);
    }

    /**
     * Test of findWinner method, of class GameState.
     */
    @Test
    public void testFindWinner() {
        System.out.println("findWinner");
        int[][] board = null;
        int expResult = 0;
        int result = GameState.findWinner(board);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of GetSubGame method, of class GameState.
     */
    @Test
    public void testGetSubGame() {
        System.out.println("GetSubGame");
        int x = 0;
        int y = 0;
        GameState instance = new GameState();
        SubGame expResult = null;
        SubGame result = instance.GetSubGame(x, y);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of GetSubBoard method, of class GameState.
     */
    @Test
    public void testGetSubBoard() {
        System.out.println("GetSubBoard");
        int x = 0;
        int y = 0;
        GameState instance = new GameState();
        int[][] expResult = null;
        int[][] result = instance.GetSubBoard(x, y);
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getStatusboard method, of class GameState.
     */
    @Test
    public void testGetStatusboard() {
        System.out.println("getStatusboard");
        GameState instance = new GameState();
        int[][] expResult = null;
        int[][] result = instance.getStatusboard();
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getMainboard method, of class GameState.
     */
    @Test
    public void testGetMainboard() {
        System.out.println("getMainboard");
        GameState instance = new GameState();
        SubGame[][] expResult = null;
        SubGame[][] result = instance.getMainboard();
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getCurrentPlayer method, of class GameState.
     */
    @Test
    public void testGetCurrentPlayer() {
        System.out.println("getCurrentPlayer");
        GameState instance = new GameState();
        int expResult = 0;
        int result = instance.getCurrentPlayer();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getWinner method, of class GameState.
     */
    @Test
    public void testGetWinner() {
        System.out.println("getWinner");
        GameState instance = new GameState();
        int expResult = 0;
        int result = instance.getWinner();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
}