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
     * Test of findWinner method, of class GameRules.
     */
    @Test
    public void testFindWinner() {
        System.out.println("findWinner");
        GameState board = null;
        int expResult = 0;
        int result = GameRules.findWinner(board);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of checkStatusBoard method, of class GameRules.
     */
    @Test
    public void testCheckStatusBoard() {
        int[][] board = new int[3][3];
        ArrayList result = new ArrayList();
        ArrayList expResult = new ArrayList();
        board[0][0] = 1;
        board[1][0] = 1;
        board[2][0] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[0][1] = 1;
        board[1][1] = 1;
        board[2][1] = 1;
        for (int x = 0; x < 3; x++)
        {
            for (int y = 0; y < 3; y++)
            {
                System.out.print(board[x][y]);
            }
            System.out.println();
        }
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[0][2] = 1;
        board[1][2] = 1;
        board[2][2] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[0][0] = 1;
        board[0][1] = 1;
        board[0][2] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[1][0] = 1;
        board[1][1] = 1;
        board[1][2] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[2][0] = 1;
        board[2][1] = 1;
        board[2][2] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[0][0] = 1;
        board[1][1] = 1;
        board[2][2] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        board = new int[3][3];
        board[0][2] = 1;
        board[1][1] = 1;
        board[2][0] = 1;
        result.add(GameRules.checkStatusBoard(board));
        expResult.add(1);

        assertEquals(expResult, result);
    }

    /**
     * Test of checkForDraw method, of class GameRules.
     */
    @Test
    public void testCheckForDraw() {
        System.out.println("checkForDraw");
        int[][] board = null;
        boolean expResult = false;
        boolean result = GameRules.checkForDraw(board);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of isDone method, of class GameRules.
     */
    @Test
    public void testIsDone() {
        System.out.println("isDone");
        GameState board = null;
        boolean expResult = false;
        boolean result = GameRules.isDone(board);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of validMove method, of class GameRules.
     */
    @Test
    public void testValidMove() {
        System.out.println("validMove");
        GameState board = null;
        Coordinates move = null;
        boolean expResult = false;
        boolean result = GameRules.validMove(board, move);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

}