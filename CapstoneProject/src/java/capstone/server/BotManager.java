/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import capstone.player.Bot;
import java.util.WeakHashMap;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Max
 * Keeps a list of active bots in a weak map.
 */
public class BotManager {
    
    //Map player IDs to their bots
    private static WeakHashMap<String, Bot> botmap = new WeakHashMap<String, Bot>();
    
    public static Bot getBot(HttpSession session){
        return getBot(session.getAttribute("email").toString());
    }
    
    public static Bot getBot(String userid){
        userid = userid.replace('.', '_').replace('@', '_');
        Bot bot = botmap.get(userid);
        if(bot!=null){
            return bot;
        }
        else{
            //TODO load bot
        }
        return GameManager.DEFAULT_BOT;
    }
}
