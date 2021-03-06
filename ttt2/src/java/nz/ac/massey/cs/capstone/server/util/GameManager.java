/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server.util;

import nz.ac.massey.cs.capstone.game.GameSession;
import nz.ac.massey.cs.capstone.game.Coordinates;
import nz.ac.massey.cs.capstone.game.GameRules;
import nz.ac.massey.cs.capstone.game.IllegalGameException;
import nz.ac.massey.cs.capstone.game.GameState;
import nz.ac.massey.cs.capstone.player.Bot;
import nz.ac.massey.cs.capstone.player.GameBot;
import nz.ac.massey.cs.capstone.server.SocialLogin;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Max, Jesse, Ryan
 */
public class GameManager {

    //public static Map<String, String> playerDetails = new ConcurrentHashMap<String, String>();
    public static Map<HttpSession, RemotePlayer> players = new ConcurrentHashMap<HttpSession, RemotePlayer>();
    public static Map<HttpSession, GameSession> gameSessions = new ConcurrentHashMap<HttpSession, GameSession>();
    public static Map<GameSession, List<HttpSession>> watchers = new ConcurrentHashMap<GameSession, List<HttpSession>>();
    public static Map<String, GameSession> gameIDs = new ConcurrentHashMap<String, GameSession>();
    public static Map<HttpSession, BlockingQueue<String>> states = new ConcurrentHashMap<HttpSession, BlockingQueue<String>>();
    public static Map<String, String> openGames = new ConcurrentHashMap<String, String>();
    public static List<String> privateGames = new ArrayList<String>();
    //For now, only one bot - DefaultBot
    public static final Bot DEFAULT_BOT = new GameBot();

//    static{
//        try {
//            ManagementFactory.getPlatformMBeanServer().registerMBean(new ServerInspector(), new ObjectName("GameManager"));
//        } catch (MalformedObjectNameException ex) {
//            Logger.getLogger(GameManager.class.getName()).log(Level.WARNING, null, ex);
//        } catch (InstanceAlreadyExistsException ex) {
//            
//        } catch (MBeanRegistrationException ex) {
//            Logger.getLogger(GameManager.class.getName()).log(Level.WARNING, null, ex);
//        } catch (NotCompliantMBeanException ex) {
//            Logger.getLogger(GameManager.class.getName()).log(Level.WARNING, null, ex);
//        }
//    }
    //Add a player to an existing game
    public static void joinGame(HttpSession session, String gameID) {
        try {
            if (gameSessions.containsKey(session)) {
                leave(session);
            }
            session.getServletContext().log("Player joining game session (ID " + gameID + ")");
            RemotePlayer player = players.get(session);
            GameSession game = gameIDs.get(gameID);
            game.Join(player);
            if (!game.isOpen()) {
                openGames.remove(game.SessionID);
            }
            gameSessions.put(session, game);
            List<HttpSession> sessions = watchers.get(game);
            if (sessions == null) {
                sessions = new ArrayList<HttpSession>();
                watchers.put(game, sessions);
            }
            sessions.add(session);
            for (HttpSession sess : watchers.get(game)) {
                String initialMessage = JSONBuilder.buildJSON(game, players.get(sess));
                states.get(sess).offer(initialMessage);
            }
        } catch (IllegalGameException ex) {
            newGame(session);
        }
    }

    public static void BotJoin(HttpSession session) {
        try {
            gameSessions.get(session).Join(DEFAULT_BOT);
            GameSession game = gameSessions.get(session);
            openGames.remove(gameSessions.get(session).SessionID);
            for (HttpSession sess : watchers.get(game)) {
                String initialMessage = JSONBuilder.buildJSON(game, players.get(sess));
                states.get(sess).offer(initialMessage);
            }
        } catch (IllegalGameException ex) {
            Logger.getLogger(GameManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void playerBotJoin(HttpSession session, Bot bot) {
        try {
            gameSessions.get(session).Join(bot);
            GameSession game = gameSessions.get(session);
            openGames.remove(gameSessions.get(session).SessionID);
            for (HttpSession sess : watchers.get(game)) {
                String initialMessage = JSONBuilder.buildJSON(game, players.get(sess));
                states.get(sess).offer(initialMessage);
            }
        } catch (IllegalGameException ex) {
            Logger.getLogger(GameManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static String getPublicGames() {
        StringBuilder builder = new StringBuilder("{\"games\":[");
        boolean first = true;
        for (Entry<String, String> entry : openGames.entrySet()) {
            if (!first) {
                builder = builder.append(", ");
            } else {
                first = false;
            }
            if (privateGames.indexOf(entry.getValue()) == -1) {
                builder = builder.append('"').append(entry.getValue()).append('"');
            }
        }

        return builder.append("]}").toString();
    }

    public static void addPrivateName(HttpSession session) {
        String username = session.getAttribute("user").toString();
        privateGames.add(username);
    }

    public static void removePrivateName(HttpSession session) {
        String username = session.getAttribute("user").toString();
        if (privateGames.indexOf(username) != -1) {
            privateGames.remove(username);
        }
    }
    
    public static String getRecordedGames(HttpSession session){
        StringBuilder builder = new StringBuilder("{\"games\":[");
        String user = session.getAttribute("user").toString();
        List games = GameRecorder.getGames(user);
        boolean first = true;
        for (Object entry : games) {
            if (!first) {
                builder = builder.append(", ");
            } else {
                first = false;
            }
            builder = builder.append(entry.toString());

        }

        return builder.append("]}").toString();
    }

    public static String getRecordedGameCoords(String gameID) {
        StringBuilder builder = new StringBuilder("{\"coords\":[");
        List coords = GameRecorder.getGameCoords(gameID);
        boolean first = true;
        for (Object entry : coords) {
            if (!first) {
                builder = builder.append(", ");
            } else {
                first = false;
            }
            builder = builder.append('"').append(entry.toString()).append('"');

        }
        return builder.append("]}").toString();
    }

    public static String getOpenGames() {
        StringBuilder builder = new StringBuilder();
        builder = builder.append("{\"games\":");
        boolean first = true;
        for (String value : openGames.values()) {
            if (!first) {
                builder = builder.append(",");
            } else {
                first = false;
            }
            builder = builder.append("[\"").append(value).append("\"]");
        }
        return builder.append("}").toString();
    }

    //Create a new game session
    public static void newGame(HttpSession session) {
        GameSession game = new GameSession();
        gameIDs.put(game.SessionID, game);
        try {
            game.Join(players.get(session));
            gameSessions.put(session, game);
            openGames.put(game.SessionID, session.getAttribute("user").toString());
            
            Logger.getLogger(GameManager.class.getName()).log(Level.INFO, "Player "+session.getAttribute("user").toString()+" joined game"+game.SessionID);
            List<HttpSession> sessions = watchers.get(game);
            if (sessions == null) {
                sessions = new ArrayList<HttpSession>();
                watchers.put(game, sessions);
            }
            sessions.add(session);
            //Initial player should start
            players.get(session).setActive(true);
            String initialMessage = "{\"open\": \"true\"}";
            states.get(session).offer(initialMessage);
        } catch (IllegalGameException ex) {
            Logger.getLogger(GameManager.class.getName()).log(Level.SEVERE, "Error creating new game", ex);
        }

    }

    public static void newPlayer(HttpSession session, String name) {
        session.setAttribute("user", name);
        players.put(session, new RemotePlayer(name));
        BlockingQueue<String> messageQueue = new ArrayBlockingQueue<String>(10);
        states.put(session, messageQueue);
    }

    public static void disconnect(HttpSession session) {
        GameManager.leave(session);
        SocialLogin.googlePlayerDetails.remove(players.get(session).toString());
        SocialLogin.facebookPlayerDetails.remove(players.get(session).toString());
        players.remove(session);
        states.remove(session);
    }

    public static void leave(HttpSession session) {
        GameSession game = gameSessions.remove(session);
        if (game != null) {
            if (!game.isOpen()) {
                game.replace(players.get(session), BotManager.getBot(session, session.getServletContext().getRealPath(".")));
            }
            
            Logger.getLogger(GameManager.class.getName()).log(Level.INFO, "Player {0} left game {1}", new Object[]{session.getAttribute("user").toString(), game.SessionID});
            
            watchers.get(game).remove(session);
            if (watchers.get(game) != null && !watchers.get(game).isEmpty()) {
                for (HttpSession s : watchers.get(game)) {
                    String nextState = JSONBuilder.buildJSON(game, players.get(s));
                    states.get(s).offer(nextState);
                }
            } else {
                removePrivateName(session);
                gameIDs.remove(game.SessionID);
                openGames.remove(game.SessionID);
                states.get(session).clear();
                watchers.remove(game);
            }
            if (game.isOpen()) {
                removePrivateName(session);
                gameIDs.remove(game.SessionID);
                openGames.remove(game.SessionID);
                states.get(session).clear();
                watchers.remove(game);
            }
        }
    }

    //Return the oldest state. If a newer state is available, remove that state.
    public static String getGame(HttpSession session) {

        //Waiting for game creation
        if(gameSessions.get(session)==null){
            return "{\"open\": \"true\"}";
        }
        
        if (gameSessions.get(session).isOpen()) {
            return "{\"open\": \"true\"}";
        } else {
            BlockingQueue<String> messages = states.get(session);
            if (messages.size() > 0) {
                return messages.poll();
            } else {
                return "{\"waiting\": \"true\"}";
            }
        }
    }

    public static String getGameID(String playerName) {
        if (openGames.containsValue(playerName)) {
            for (Entry<String, String> entry : openGames.entrySet()) {
                if (entry.getValue().equals(playerName)) {
                    return entry.getKey();
                }
            }
        }
        return null;
    }

    public static String getAnyGameID(GameSession game) {
        for (Entry<String, GameSession> entry : gameIDs.entrySet()) {
            if (entry.getValue().equals(game)) {
                return entry.getKey();
            }
        }
        return null;
    }

    public static RemotePlayer getPlayer(HttpSession session) {
        return players.get(session);
    }

    public static void makeMove(HttpSession session, int a, int b, int x, int y) {
        Coordinates coords = new Coordinates(a, b, x, y);
        GameSession game = gameSessions.get(session);
        RemotePlayer player = players.get(session);
        GameState board = game.getCurrentGame();
        //only move if we're supposed to
        if (player.isActive()) {
            if (GameRules.validMove(board, coords) && !game.isOpen() && game.getCurrentPlayer().equals(player)) {
                player.setActive(false);
                game.move(player, coords);
                //GameRecorder.record(getAnyGameID(game), session.getAttribute("user").toString(), coords.getAllCoords());
                for (HttpSession s : watchers.get(game)) {
                    String nextState = JSONBuilder.buildJSON(game, players.get(s));
                    states.get(s).offer(nextState);
                }
            }

        }
    }

    public static void joinAnyGame(HttpSession session) {
        synchronized (openGames) {
            if (openGames.isEmpty()) {
                GameManager.newGame(session);
                return;
            } else {
                String firstOpen = openGames.keySet().iterator().next();
                String firstPlayer = openGames.values().iterator().next();
                if (privateGames.indexOf(firstPlayer) == -1) {
                    joinGame(session, firstOpen);
                } else {
                    GameManager.newGame(session);
                }
            }
        }
    }
}
