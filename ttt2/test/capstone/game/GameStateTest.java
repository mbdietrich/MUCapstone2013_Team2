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
    public void testGetSubGame() 
    {
        GameState state = new GameState();
        
        state.PlacePiece(new Coordinates(1,1,1,1), 1);
        SubGame game = state.GetSubGame(1, 1);
        int[][] board = game.getBoard();
        int[][] expBoard = new int[][]{{0,0,0},{0,1,0},{0,0,0}};
        //Tests that a SubGame from the GameState will have the proper values placed in the 
        //correct positions.
        assertArrayEquals(board, expBoard);
    }

    /**
     * Test of GetSubBoard method, of class GameState.
     */
    @Test
    public void testGetSubBoard() 
    {
        GameState state = new GameState();
        
        state.PlacePiece(new Coordinates(1,1,1,1), 1);
        int[][] board = state.GetSubBoard(1, 1);
        int[][] expBoard = new int[][]{{0,0,0},{0,1,0},{0,0,0}};
        for(int x = 0; x < 3; x++)
        assertArrayEquals(board, expBoard);
    }

    /**
     * Test of getStatusboard method, of class GameState.
     */
    @Test
    public void testGetStatusboard() 
    {
        GameState state = new GameState();
        
        state.PlacePiece(new Coordinates(1,1,0,0), 1);
        state.PlacePiece(new Coordinates(1,1,1,1), 1);
        state.PlacePiece(new Coordinates(1,1,2,2), 1);
        int[][] statusBoard = state.getStatusboard();
        int[][] expStatusBoard = new int[][]{{0,0,0},{0,1,0},{0,0,0}};
        //Test that the status board gotten from the GameState is correct, mainly that it has
        //recognised one of the subgames has been won.
        assertArrayEquals(statusBoard, expStatusBoard);
    }

    /**
     * Test of getMainboard method, of class GameState.
     */
    @Test
    public void testGetMainboard() {
        GameState state = new GameState();
        SubGame[][] subgames = state.getMainboard();
        SubGame expGame = new SubGame();
        //Test that the subgame gotten from the GameState has the same initial values
        //as one directly created.
        assertArrayEquals(subgames[1][1].getBoard(), expGame.getBoard());
    }

    /**
     * Test of getCurrentPlayer method, of class GameState.
     */
    @Test
    public void testGetCurrentPlayer() {
        GameState state = new GameState();
        assertEquals(state.getCurrentPlayer(), 1);
    }

    /**
     * Test of getWinner method, of class GameState.
     */
    @Test
    public void testGetWinner() {
        GameState state = new GameState();
        ArrayList<Coordinates> coords = new ArrayList<Coordinates>();
        ArrayList expResults = new ArrayList();
        ArrayList results = new ArrayList();
        //Check that it begins by having no winner.
        results.add(state.getWinner());
        expResults.add(0);
        
        //win the match.
        coords.add(new Coordinates(0,0,0,0));
        coords.add(new Coordinates(0,0,1,1));
        coords.add(new Coordinates(0,0,2,2));
        coords.add(new Coordinates(1,1,0,0));
        coords.add(new Coordinates(1,1,1,1));
        coords.add(new Coordinates(1,1,2,2));
        coords.add(new Coordinates(2,2,0,0));
        coords.add(new Coordinates(2,2,1,1));
        coords.add(new Coordinates(2,2,2,2));
        for(Coordinates coord:coords)
        {
            state.PlacePiece(coord, 1);
        }
        //Check that it returns the right player as winner of the match.
        results.add(state.getWinner());
        expResults.add(1);
        assertEquals(results, expResults);
    }
}