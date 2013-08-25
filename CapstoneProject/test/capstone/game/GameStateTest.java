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
    public void testPlacePiece() 
    {
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
    public void testFindWinner() 
    {
        int[][] board = new int[][]{{1,1,1},{0,0,0},{0,0,0}};
        int winner = GameState.findWinner(board);
        assertEquals(winner, 1);     
    }

    /**
     * Test of GetSubGame method, of class GameState.
     */
    @Test
    public void testGetSubGame() {
        GameState state = new GameState();
        
        state.PlacePiece(new Coordinates(1,1,1,1), 1);
        SubGame game = state.GetSubGame(1, 1);
        int[][] board = game.getBoard();
        int[][] expBoard = new int[][]{{0,0,0},{0,1,0},{0,0,0}};
        for(int x = 0; x < 3; x++)
        {
            for(int y = 0; y < 3; y++)
            {
                assertEquals(board[x][y], expBoard[x][y]);
            }
        }
    }

    /**
     * Test of GetSubBoard method, of class GameState.
     */
    @Test
    public void testGetSubBoard() {
        GameState state = new GameState();
        
        state.PlacePiece(new Coordinates(1,1,1,1), 1);
        int[][] board = state.GetSubBoard(1, 1);
        int[][] expBoard = new int[][]{{0,0,0},{0,1,0},{0,0,0}};
        for(int x = 0; x < 3; x++)
        {
            for(int y = 0; y < 3; y++)
            {
                assertEquals(board[x][y], expBoard[x][y]);
            }
        }
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