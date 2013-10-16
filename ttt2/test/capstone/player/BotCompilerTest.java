/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.player.bot.BotCompilationException;
import capstone.player.bot.BotCompiler;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;
import org.junit.Test;

/**
 *
 * @author Max
 */
public class BotCompilerTest {
    private static final String PATH = "build/test";
    
    //Valid compilation
    @Test
    public void testValidComp() throws BotCompilationException, IOException{
        String source = new Scanner(new File("testfiles/valid.txt")).useDelimiter("\\Z").next();
        Bot bot = BotCompiler.createBot(source, "Valid", PATH);
    }
}
