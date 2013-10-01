/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import org.junit.*;
import static org.junit.Assert.*;
import capstone.player.TestExcecutor;
import java.lang.reflect.InvocationTargetException;

/**
 *
 * @author Max
 */
public class BotValidatorTest {
    
    public BotValidatorTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }
    
    
    @Test
    public void defaultBotTest() throws InvocationTargetException, IllegalAccessException{
        Bot bot = new GameBot();
        String message = TestExcecutor.testBot(bot);
        System.out.println(message);
        assertEquals(message, "Pass");
    }
}