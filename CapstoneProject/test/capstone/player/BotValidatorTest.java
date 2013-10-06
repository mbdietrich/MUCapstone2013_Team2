/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import org.junit.*;
import static org.junit.Assert.*;
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
    
    @Test(timeout=10000)
    public void infiniteLoopTest() throws InvocationTargetException, IllegalAccessException{
        Bot bot = new InfiniteLoopBot();
        String message = TestExcecutor.testBot(bot);
        System.out.println(message);
        assertTrue(message.contains("timed out"));
    } 
    
    @Test
    public void testValidMove() throws InvocationTargetException, IllegalAccessException{
        Bot bot = new InvalidMover();
        String message = TestExcecutor.testBot(bot);
        System.out.println(message);
        assertNotSame("Pass", message);
    } 
    
    @Test
    public void testValidName() throws InvocationTargetException, IllegalAccessException{
        Bot bot = new InvalidName();
        String message = TestExcecutor.testBot(bot);
        System.out.println(message);
        assertTrue(message.endsWith("failed"));
    } 
}