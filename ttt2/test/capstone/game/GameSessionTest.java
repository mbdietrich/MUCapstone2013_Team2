/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

import nz.ac.massey.cs.capstone.game.Coordinates;
import nz.ac.massey.cs.capstone.game.GameSession;
import nz.ac.massey.cs.capstone.game.GameState;
import nz.ac.massey.cs.capstone.game.IllegalGameException;
import nz.ac.massey.cs.capstone.player.Player;
import nz.ac.massey.cs.capstone.server.util.RemotePlayer;
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
     * Tests that getCurrentGame does get a GameState and that it is the current game.
     */
    @Test
    public void testGetCurrentGame() {
        GameSession session = new GameSession();
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        ArrayList expResult = new ArrayList();
        ArrayList result = new ArrayList();
        
        try
        {
            session.Join(player1);
            session.Join(player2);
            Coordinates player1Move = new Coordinates(1,1,1,1);
            Coordinates player2Move = new Coordinates(2,2,2,2);
            
            session.move(player1, player1Move);
            session.move(player2, player2Move);
            GameState state = session.getCurrentGame();
            
            if (state.GetSubBoard(1, 1)[1][1] == 1)
            {
                result.add(true);
            }
            else result.add(false);
            expResult.add(true);
            if (state.GetSubBoard(2, 2)[2][2] == 2)
            {
                result.add(true);
            }
            else result.add(false);
            expResult.add(true);
            
            assertEquals(result, expResult);
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
        
    }

    /**
     * Tests that two players are able to join a game, and the session should not
     * be open.
     */
    @Test
    public void testJoin1()
    {
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        Boolean flag = false;
        GameSession session = new GameSession();
        
        try
        {
            session.Join(player1);
            session.Join(player2);
        
            if (!session.isOpen())
            {
                flag = true;
            }
            assertTrue(flag);
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
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
    public void testIsOpen()
    {
        Player player1 = new RemotePlayer("Player1");
        Player player2 = new RemotePlayer("Player2");
        GameSession session = new GameSession();
        
        try
        {
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
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
    }
    
    /**
     * Tests that when a player makes a legal move, it is placed in the GameState.
     */
    @Test
    public void testMove1()
    {
        GameSession session = new GameSession();
        Player player1 = new RemotePlayer("Player1");
        Player player2 = new RemotePlayer("Player2");
        
        try
        {
            session.Join(player1);
            session.Join(player2);
            Coordinates player1Move = new Coordinates(1,1,1,1);
            
            session.move(player1, player1Move);
            GameState currentGame = session.getCurrentGame();
            if(currentGame.GetSubBoard(1, 1)[1][1] == 1)
            {
                assertTrue(true);
            }
            else fail("The move was not placed");
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
    }

    /**
     * Tests that the currentPlayer is changed after making a move in the Move method.
     */
    @Test
    public void testMove2() 
    {
        GameSession session = new GameSession();
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        
        try
        {
            session.Join(player1);
            session.Join(player2);
            Coordinates player1Move = new Coordinates(1,1,1,1);
            Coordinates player2Move = new Coordinates(1,1,0,0);
            session.move(player1, player1Move);
            //After player1 makes a move, currentPlayer should be player2
            if (session.getCurrentPlayer() == player1)
            {
                fail("It is still player1's turn.");
            }
            session.move(player2, player2Move);
            //After player2 makes a move, currentPlayer should change back to player1
            if (session.getCurrentPlayer() == player2)
            {
                fail("It is still player2's turn.");
            }
            else if(session.getCurrentPlayer() == player1)
            {
                assertTrue(true);
            }
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        } 
    }
    
    /**
     * Tests that one player cannot make two moves in a row.
     */
    @Test
    public void testMove3()
    {
        GameSession session = new GameSession();
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        
        try
        {
            session.Join(player1);
            session.Join(player2);
            Coordinates player1Move = new Coordinates(1,1,1,1);
            Coordinates player1Move2 = new Coordinates(1,1,0,0);
            
            session.move(player1, player1Move);
            session.move(player1, player1Move);
            
            GameState currentGame = session.getCurrentGame();
            if (currentGame.GetSubBoard(1, 1)[0][0] == 1)
            {
                fail("Player was able to make two moves in a row.");
            }
            else assertTrue(true);
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
    }
    
    /**
     * Tests that a player cannot play in a match that has been won.
     */
    @Test
    public void testMove4()
    {
        GameSession session = new GameSession();
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        
        try
        {
            session.Join(player1);
            session.Join(player2);
            
            //Player1 wins a subgame
            Coordinates coord1 = new Coordinates(1,1,0,0);
            Coordinates coord2 = new Coordinates(1,1,1,1);
            Coordinates coord3 = new Coordinates(1,1,1,0);
            Coordinates coord4 = new Coordinates(1,1,2,2);
            Coordinates coord5 = new Coordinates(1,1,2,0);
            session.move(player1, coord1);
            session.move(player2, coord2);
            session.move(player1, coord3);
            session.move(player2, coord4);
            session.move(player1, coord5);
            
            //player2 trys to play in finished subgame
            Coordinates player2Move = new Coordinates(1,1,1,2);
            session.move(player2, player2Move);
            GameState state = session.getCurrentGame();
            if (state.GetSubBoard(1, 1)[1][2] == 2)
            {
                fail("Player2 was able to play in a finished subgame.");
            }
            else assertTrue(true);
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
    }

    /**
     * Test of getPlayerNumber method, of class GameSession.
     */
    @Test
    public void testGetPlayerNumber()
    {
        ArrayList result = new ArrayList();
        ArrayList expResult = new ArrayList();
        Player player1 = new RemotePlayer("player1");
        Player player2 = new RemotePlayer("player2");
        GameSession session = new GameSession();
        
        try
        {
            session.Join(player1);
            session.Join(player2);
        
            result.add(session.getPlayerNumber(player1));
            expResult.add(1);
            result.add(session.getPlayerNumber(player2));
            expResult.add(2);
        
            assertEquals(result, expResult);
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
    }

    /**
     * Test of Leave method, of class GameSession.
     */
    @Test
    public void testLeave()
    {
        Player player1 = new RemotePlayer("Player1");
        Player player2 = new RemotePlayer("Player2");
        Boolean flag = false;
        GameSession session = new GameSession();
        
        try
        {
            session.Join(player1);
            session.Join(player2);
            session.Leave(player2);
        
            if (session.getGameWinner() == player1)
            {
                flag = true;
            }
            assertTrue(flag);
        }
        catch(IllegalGameException e)
        {
            fail("Threw an IllegalGameException");
        }
    }
}