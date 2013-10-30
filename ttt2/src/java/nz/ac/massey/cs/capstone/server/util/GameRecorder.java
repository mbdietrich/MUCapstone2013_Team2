/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server.util;

import nz.ac.massey.cs.capstone.player.GameRecord;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

public class GameRecorder {

    private static Map<String, List<String>> playerRecords = new ConcurrentHashMap<String, List<String>>();  //PlayerName -> GameID
    private static Map<String, GameRecord> gameIDRecords = new ConcurrentHashMap<String, GameRecord>();      //GameID -> GameRecord

    public static void record(String gameID, String player, String coords) {

        if (!playerRecords.containsKey(player)) {
            playerRecords.put(player, new ArrayList<String>());
        }
        if (playerRecords.get(player).indexOf(gameID) == -1) {
            GameRecord game;
            if (gameIDRecords.get(gameID) == null) {
                game = new GameRecord();
                playerRecords.get(player).add(gameID);
            } else {
                game = gameIDRecords.get(gameID);
            }
            game.putCoords(coords);
            if (gameIDRecords.get(gameID) != game) {
                gameIDRecords.put(gameID, game);
            }
        } else {
            gameIDRecords.get(gameID).putCoords(coords);
        }
        GameRecord game = gameIDRecords.get(gameID);
        if (game.getPlayer1().equals("")) {
            game.setGameID(gameID);
            game.setPlayer1(player);
        } else if (!player.equals(game.getPlayer1()) && game.getPlayer2().equals("")) {
            game.setPlayer2(player);
        }
    }

    public static List<String> getGames(String player) {
        List<String> games = playerRecords.get(player);
        List<String> gamePlayers = new ArrayList();
        for (String e : games) {
            GameRecord temp = gameIDRecords.get(e);
            String playerTemp = "{" + "\"gid\": \"" + temp.getGameID() + "\" , \"p1\" :\"" + temp.getPlayer1() + "\" , \"p2\" :\"" + temp.getPlayer2() + "\"}";
            gamePlayers.add(playerTemp);
        }
        return gamePlayers;
    }

    public static List<String> getGameCoords(String gameID) {
        GameRecord record = gameIDRecords.get(gameID);
        List temp = record.getCoords();
        return temp;
    }
}
