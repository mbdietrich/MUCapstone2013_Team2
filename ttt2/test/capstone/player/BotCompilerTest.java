/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.player.bot.BotCompiler;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;
import org.junit.Test;
import capstone.player.bot.BotCompilationException;
import java.net.MalformedURLException;
import java.net.URL;
import org.junit.BeforeClass;

/**
 *
 * @author Max
 */
public class BotCompilerTest {
    private static final String PATH = "build/test";
    private static URL JARPATH;
    
    @BeforeClass
    public static void setUp() throws MalformedURLException{
        JARPATH = new File("web/WEB-INF/lib/botcode.jar").toURI().toURL();
    }
    
    //Valid compilation
    @Test
    public void testValidComp() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/valid.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "Valid", PATH, JARPATH);
    }
    
    @Test(expected = BotCompilationException.class)
    public void testInvalidMethod() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/infiniteloop.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "Invalid", PATH, JARPATH);
    }
    
    @Test(expected = BotCompilationException.class)
    public void testInvalidSyntax() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/badsyntax.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "BadSyntax", PATH, JARPATH);
    }
    
     @Test(expected = BotCompilationException.class)
    public void testUnsafeUsage() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/unsafeapi.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "UnsafeUsage", PATH, JARPATH);
    }
}
