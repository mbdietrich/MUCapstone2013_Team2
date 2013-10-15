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
 * @author rjmurphy
 */
public class GameRulesTest {

    public GameRulesTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }

    /**
     * Test a win across the first row
     */
    @Test
    public void testRow1(){
        int[][] board = new int[3][3];
        board[0][0] = 1;
        board[1][0] = 1;
        board[2][0] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

     /**
     * Test a win across the second row
     */
    @Test
    public void testRow2(){
        int[][] board = new int[3][3];
        board[0][1] = 1;
        board[1][1] = 1;
        board[2][1] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

    /**
     * Test a win across the third row
     */
    @Test
    public void testRow3(){
        int[][] board = new int[3][3];
        board[0][2] = 1;
        board[1][2] = 1;
        board[2][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

     /**
     * Test a win across the first column
     */
    @Test
    public void testCol1(){
        int[][] board = new int[3][3];
        board[0][0] = 1;
        board[0][1] = 1;
        board[0][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

    /**
     * Test a win across the second column
     */
    @Test
    public void testCol2(){
        int[][] board = new int[3][3];
        board[1][0] = 1;
        board[1][1] = 1;
        board[1][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

    /**
     * Test a win across the third column
     */
    @Test
    public void testCol3(){
        int[][] board = new int[3][3];
        board[2][0] = 1;
        board[2][1] = 1;
        board[2][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

    /**
     * Test a win across the diagonal from top left to bottom right
     */
    @Test
    public void testDiagonal1(){
        int[][] board = new int[3][3];
        board[0][0] = 1;
        board[1][1] = 1;
        board[2][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

     /**
     * Test a win across the diagonal from top right to bottom left
     */
    @Test
    public void testDialongal2(){
        int[][] board = new int[3][3];
        board[2][0] = 1;
        board[1][1] = 1;
        board[0][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 1);
    }

     /**
     * Test a a game which has been drawn (closed game, no winner)
     */
    @Test
    public void testDraw(){
        int[][] board = new int[3][3];
        board[0][0] = 1;
        board[0][1] = 1;
        board[0][2] = 2;
        board[1][0] = 2;
        board[1][1] = 2;
        board[1][2] = 1;
        board[2][0] = 1;
        board[2][1] = 2;
        board[2][2] = 1;

        int result = (GameRules.checkStatusBoard(board));
        assertEquals(result, 3);
    }

    /**
     * Test of isDone method, of class GameRules.
     */
    @Test
    public void testIsDone() {
        // Make a new GameState. The game board is filled with zeros, so
        // isDone should be false
        GameState newGame = new GameState();
        boolean expResult = false;
        boolean result = GameRules.isDone(newGame);
        assertEquals(expResult, result);
    }

    /**
     * Test of validMove method, of class GameRules.
     */
    @Test
    public void testValidMove() {
        ArrayList results = new ArrayList();
        ArrayList expResults = new ArrayList();
        GameState state = new GameState();
        Coordinates coord = new Coordinates(0,0,0,0);

        if (GameRules.validMove(state, coord))
        {
            results.add(1);
            state.PlacePiece(coord, 2);
        }
        else results.add(0);
        expResults.add(1);

        if (GameRules.validMove(state, coord))
        {
            results.add(1);
        }
        else results.add(0);
        expResults.add(0);
        
        coord = new Coordinates(0,0,1,1);
        if (GameRules.validMove(state, coord))
        {
            results.add(1);
            state.PlacePiece(coord, 2);
        }
        else results.add(0);
        expResults.add(1);

        coord = new Coordinates(0,0,2,2);
        if (GameRules.validMove(state, coord))
        {
            results.add(1);
            state.PlacePiece(coord, 2);
        }
        else results.add(0);
        expResults.add(1);

        coord = new Coordinates(0,0,1,2);
        if (GameRules.validMove(state, coord))
        {
            results.add(1);
        }
        else results.add(0);
        expResults.add(0);

        assertEquals(expResults, results);
    }

}