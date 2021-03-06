/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server.util;

import nz.ac.massey.cs.capstone.player.Bot;
import nz.ac.massey.cs.capstone.player.bot.BotCompilationException;
import nz.ac.massey.cs.capstone.player.bot.BotCompiler;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Max
 * Keeps a list of active bots in a weak map.
 */
public class BotManager {
    
    //Map player IDs to their bots
    private static Map<String, Bot> botmap = new HashMap<String, Bot>();
    private static final String sep = System.getProperty("file.separator");
    
    public static Bot getBot(HttpSession session, String PATH){
        return getBot(session.getAttribute("email").toString(), PATH);
    }
    
    public static Bot getBot(String userid, String PATH){
        userid = "C"+userid.replace('.', '_').replace('@', '_');
        Bot bot = botmap.get(userid);
        
        if(bot!=null){
            return bot;
        }
        else{
            bot = BotCompiler.load(userid, PATH);
            botmap.put(userid, bot);
            return bot;
        }
    }
    
    public static String getSource(String userid, String PATH){
        try {
            userid = "C"+userid.replace('.', '_').replace('@', '_');
            Scanner sc = new Scanner(new File(PATH+"src"+sep+userid+".src"));
            sc.useDelimiter("\\Z");
            String code = sc.next();
            sc.close();
            return code;
        } catch (FileNotFoundException ex) {
            //No code to set, use default code.
            return "";
        }
    }
    
    public static void compile(String userid, String code, String PATH) throws BotCompilationException{
        
        
        userid = "C"+userid.replace('.', '_').replace('@', '_');
        try {
            Bot bot = BotCompiler.createBot(code, userid, PATH);
            botmap.put(userid, bot);
        } catch (IOException ex) {
            throw new BotCompilationException("Internal error validating bot.");
        }
    }
    
    public static Map<String, Bot> getAllBots() {
        return botmap;
    }
}
