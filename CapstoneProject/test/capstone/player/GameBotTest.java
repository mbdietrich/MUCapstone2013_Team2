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
     * Test that the next method makes valid moves, of class GameBot.
     */
    @Test
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
            }
            else
            {
                flag = false;
                fail("The bot played an invalid move.");
            }
        }
        assertTrue(flag);
    }

    /**
     * Test that the bot does not hang.
     */
    //TODO Decide on a proper time
    @Test(timeout=100)
    public void testNext2() {
        GameState state = new GameState();
        GameBot instance = new GameBot();
        int player = 1;
        while (!GameRules.isDone(state))
        {
            Coordinates coords = instance.next(state, player);
            if (GameRules.validMove(state, coords))
            {
                state.PlacePiece(coords, player);
            }
        }
        assertTrue(GameRules.isDone(state));
        
    }
    /**
     * Test of getName method, of class GameBot.
     */
    @Test
    public void testGetName() {
        GameBot instance = new GameBot();
        String expResult = "Default Bot";
        String result = instance.getName();
        assertEquals(expResult, result);
    }
}