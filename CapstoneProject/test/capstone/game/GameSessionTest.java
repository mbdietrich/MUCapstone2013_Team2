/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

import capstone.player.Player;
import capstone.server.RemotePlayer;
import java.util.ArrayList;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Ryan
 */
public class GameSessionTest {
    
    public GameSessionTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getCurrentGame method, of class GameSession.
     */
    @Test
    public void testGetCurrentGame() {
        //System.out.println("getCurrentGame");
        GameSession instance = new GameSession();
        GameState expResult = null;
        GameState result = instance.getCurrentGame();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * 
     */
    @Test
    public void testJoin1() throws IllegalGameException
    {
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        Boolean flag = false;
        GameSession session = new GameSession();
        
        session.Join(player1);
        session.Join(player2);
        
        if (!session.isOpen())
        {
            flag = true;
        }
        assertTrue(flag);
    }
    
    /**
     * Test for IllegalGameException in the Join method by trying to put three players in one session.
     */
    @Test(expected = IllegalGameException.class)
    public void testJoin2() throws IllegalGameException
    {
        Player player1 = new RemotePlayer("Player1");
        Player player2 = new RemotePlayer("Player2");
        Player player3 = new RemotePlayer("Player3");
        GameSession session = new GameSession();
        
        session.Join(player1);
        session.Join(player2);
        session.Join(player3);
    }

    /**
     * Test of isOpen method, of class GameSession.
     */
    @Test
    public void testIsOpen() throws IllegalGameException
    {
        Player player1 = new RemotePlayer("Player1");
        Player player2 = new RemotePlayer("Player2");
        GameSession session = new GameSession();
        session.Join(player1);
        session.Join(player2);
        
        if (session.isOpen())
        {
            fail("Session is still open.");
        }
        else
        {
            assertTrue(true);
        }
    }

    /**
     * Test of move method, of class GameSession.
     */
    @Test
    public void testMove() 
    {
        //System.out.println("move");
        Player player = null;
        Coordinates move = null;
        GameSession instance = new GameSession();
        instance.move(player, move);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getPlayerNumber method, of class GameSession.
     */
    @Test
    public void testGetPlayerNumber() throws IllegalGameException
    {
        ArrayList result = new ArrayList();
        ArrayList expResult = new ArrayList();
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        GameSession session = new GameSession();
        
        session.Join(player1);
        session.Join(player2);
        
        result.add(session.getPlayerNumber(player1));
        expResult.add(1);
        result.add(session.getPlayerNumber(player2));
        expResult.add(2);
        
        assertEquals(result, expResult);
    }

    /**
     * Test of Leave method, of class GameSession.
     */
    @Test
    public void testLeave() throws IllegalGameException
    {
        Player player1 = new RemotePlayer("Player1");
        Player player2 = new RemotePlayer("Player2");
        Boolean flag = false;
        GameSession session = new GameSession();
        
        session.Join(player1);
        session.Join(player2);
        session.Leave(player2);
        
        if (session.isOpen())
        {
            flag = true;
        }
        assertTrue(flag);
    }
}