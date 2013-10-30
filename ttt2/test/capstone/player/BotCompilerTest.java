/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import nz.ac.massey.cs.capstone.player.Bot;
import nz.ac.massey.cs.capstone.player.bot.BotCompiler;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;
import org.junit.Test;
import nz.ac.massey.cs.capstone.player.bot.BotCompilationException;
import java.net.URL;

/**
 *
 * @author Max
 */
public class BotCompilerTest {
    private static final String PATH = "./build/test";
    
    //Valid compilation
    @Test
    public void testValidComp() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/valid.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "Valid", PATH);
    }
    
    @Test(expected = BotCompilationException.class)
    public void testInvalidMethod() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/infiniteloop.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "Invalid", PATH);
    }
    
    @Test(expected = BotCompilationException.class)
    public void testInvalidSyntax() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/badsyntax.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "BadSyntax", PATH);
    }
    
     @Test(expected = BotCompilationException.class)
    public void testUnsafeUsage() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/unsafeapi.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "UnsafeUsage", PATH);
    }
}
