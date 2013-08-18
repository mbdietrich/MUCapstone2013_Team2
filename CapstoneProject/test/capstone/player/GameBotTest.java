/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.Coordinates;
import capstone.game.GameRules;
import capstone.game.GameState;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Ryan
 */
public class GameBotTest {
    
    public GameBotTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test that the next method makes valid moves, and does not hang.
     */
    @Test(timeout=100)
    public void testNext() {
        GameState state = new GameState();
        int player = 1;
        GameBot instance = new GameBot();
        Boolean flag = true;
        while (!GameRules.isDone(state))
        {
            Coordinates coords = instance.next(state, player);
            if (GameRules.validMove(state, coords))
            {
                state.PlacePiece(coords, player);
                if (player == 1)
                {
                    player = 2;
                }
                else
                {
                    player = 1;
                }
            }
            else
            {
                flag = false;
                fail("The bot played an invalid move at " + coords.getOuterX() + coords.getOuterY() + coords.getInnerX() + coords.getInnerY());
            }
        }
        assertTrue(flag);
    }

    /**
     * Test of getName method, of class GameBot.
     */
    @Test
    public void testGetName() {
        GameBot instance = new GameBot();
        String expResult = "DefaultBot";
        String result = instance.getName();
        assertEquals(expResult, result);
    }
}