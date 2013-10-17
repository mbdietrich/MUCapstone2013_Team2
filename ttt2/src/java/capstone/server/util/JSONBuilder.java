/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server.util;

import capstone.game.GameSession;
import capstone.game.GameState;

/**
 *
 * @author Max
 * Utility class to convert the necessary information from GameSession into a JSON object
 */
public class JSONBuilder {
    
    public static String buildJSON(GameSession game, RemotePlayer target){
        StringBuilder builder = new StringBuilder();
        
        builder = builder
        .append("{")
        .append(buildPlayerNumber(game, target))
        .append(",")
        .append(buildOpponent(game,target))
        .append(",")
        .append(buildIsTurn(game,target))
        .append(",")
        .append(buildGameStatus(game, target))
        .append(",")
        .append(buildGameWon(game))
        .append(",")
        .append(buildBoardObject(game))
        .append("}")
        .append(buildSubGameStatus(game))
        .append(",");
        
        return builder.toString();
    }
    
    public static String buildPlayerNumber(GameSession game, RemotePlayer target){
    	StringBuilder builder = new StringBuilder();
    	
    	int playerNumber = game.getPlayerNumber(target);
    	
		builder = builder.append("\"PlayerNumber\":\"").append(Integer.toString(playerNumber)).append("\"");
		
		return builder.toString();
    }
    
    public static String buildIsTurn(GameSession game, RemotePlayer target){
    	StringBuilder builder = new StringBuilder();
    	
    	String turn = Boolean.toString(target.isActive());
    	
		builder = builder.append("\"isTurn\":\"").append(turn).append("\"");
		
		return builder.toString();
    }
    
    public static String buildGameStatus(GameSession game, RemotePlayer target){
    	StringBuilder builder = new StringBuilder();
        
    	String winner = null;
    	
        if(game.getGameWinner()!=null){
            winner=Integer.toString(game.getPlayerNumber(game.getGameWinner()));
        }
        else{
            winner = Integer.toString(game.getCurrentGame().getWinner());
        }
        
		builder = builder.append("\"Status\":\"").append(winner).append("\"");
		
		return builder.toString();
    }
    
    public static String buildGameWon(GameSession game){
        StringBuilder builder = new StringBuilder();
        GameState state = game.getCurrentGame();
        Boolean result = game.isOpen();
        result.toString();
        
        builder = builder.append("\"isGameFinished\":\"").append(result).append("\"");
        return builder.toString();
    }
    
    public static String buildBoardObject(GameSession game){
    	StringBuilder builder = new StringBuilder();
    	
    	builder = builder.append("\"Board\":").append(buildBoardOnly(game));
    	
    	return builder.toString();
    }
    
    //Returns an array of length 9 containing all subgames
    public static String buildBoardOnly(GameSession game){
    	StringBuilder builder = new StringBuilder();
        
    	builder = builder.append("[");
    	for (int a = 0; a < 3; a++){
    		for(int b=0; b<3; b++){
                    //Build each of the subgames
                    int[][] sub = game.getCurrentGame().GetSubBoard(a, b);
                    builder=builder.append(buildSub(sub));
                    if(a<2||b<2){
                        builder=builder.append(",");
                    }
                }
    	}
    	builder = builder.append("]");
    	
    	return builder.toString();
    }
    
    //Returns an array of length 9 that encodes a subgame state
    public static String buildSub(int[][] board){
    	StringBuilder builder = new StringBuilder();
    	builder=builder.append("[");
    	for (int i = 0; i < 3; i++){
    		for(int j=0; j<3; j++){
                    builder=builder.append("\"").append(Integer.toString(board[i][j])).append("\"");
                    if(i<2||j<2){
                        builder=builder.append(",");
                    }
                }
    	}
    	builder=builder.append("]");
    	return builder.toString();
    }

    private static String buildSubGameStatus(GameSession game) {
        StringBuilder builder = new StringBuilder("\"Substatus\":[");
        for (int i = 0; i < 3; i++){
    		for(int j=0; j<3; j++){
                    builder=builder.append("\"").append(Integer.toString(game.getCurrentGame().getStatusboard()[i][j])).append("\"");
                    if(i<2||j<2){
                        builder=builder.append(",");
                    }
                }
        }
        builder=builder.append("]");
        return builder.toString();
    }

    private static String buildOpponent(GameSession game, RemotePlayer target) {
        StringBuilder builder = new StringBuilder("\"Opponent\": ");
        
        builder = builder.append("\"").append(game.getOpponentName(target)).append("\"");
        return builder.toString();
    }
}
