/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import capstone.game.GameSession;
import capstone.game.IllegalGameException;
import capstone.player.Player;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Max
 */
public class GameManager {
    
    static Map<HttpSession, Player> players = new ConcurrentHashMap<HttpSession, Player>();
    static Map<HttpSession, GameSession> gameSessions = new ConcurrentHashMap<HttpSession, GameSession>();
    static Map<String, GameSession> gameIDs = new ConcurrentHashMap<String, GameSession>();
    
    //Add a player to an existing game
    public static void addPlayer(HttpSession session, String gameID){
        try {
            session.getServletContext().log("Player joining game session (ID "+gameID+")");
            Player player = players.get(session);
            gameIDs.get(gameID).Join(player);
        } catch (IllegalGameException ex) {
            newGame(session);
        }
    }
    
    public static void newGame(HttpSession session){
        //TODO create a new game for a player.
    }
    
    public static void newPlayer(HttpSession session){
        if(!players.containsKey(session)){
            players.put(session, new RemotePlayer(session));
        }
    }
    
    public static void disconnect (HttpSession session) {
        //TODO method for removing player session
        //Remove entry form players and gameSessions, force forfeit if in game
    }
    
    public static GameSession getGame(HttpSession session){
        return gameSessions.get(session);
    }
    
    
}
