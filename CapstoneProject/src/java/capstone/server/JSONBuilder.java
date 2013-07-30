/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import capstone.game.GameSession;
import capstone.player.Player;

/**
 *
 * @author Max
 * Utility class to convert the necessary information from GameSession into a JSON object
 */
public class JSONBuilder {
    
    public static String buildJSON(GameSession game, RemotePlayer target){
        StringBuilder builder = new StringBuilder();
        
        builder = builder
        .append(buildPlayerNumber(game, target))
        .append(buildIsTurn(game,target))
        .append(buildGameStatus(game, target))
        .append(buildBoardObject(game));
        
        return builder.toString();
    }
    
    public static String buildPlayerNumber(GameSession game, RemotePlayer target){
    	StringBuilder builder = new StringBuilder();
    	
    	int playerNumber = game.getPlayerNumber(target);
    	
		builder = builder
		.append('{')
		.append("\"PlayerNumber\":\"").append(Integer.toString(playerNumber)).append("\"")
		.append('}');
		
		return builder.toString();
    }
    
    public static String buildIsTurn(GameSession game, RemotePlayer target){
    	StringBuilder builder = new StringBuilder();
    	
    	String turn = Boolean.toString(target.isActive());
    	
		builder = builder
		.append('{')
		.append("\"isTurn\":\"").append(turn).append("\"")
		.append('}');
		
		return builder.toString();
    }
    
    public static String buildGameStatus(GameSession game, RemotePlayer target){
    	StringBuilder builder = new StringBuilder();
    	
    	String winner = Integer.toString(game.getCurrentGame().getWinner());
    	
		builder = builder
		.append('{')
		.append("\"Status\":\"").append(winner).append("\"")
		.append('}');
		
		return builder.toString();
    }
    
    public static String buildBoardObject(GameSession game){
    	StringBuilder builder = new StringBuilder();
    	
    	builder = builder
		.append('{')
		.append("\"Board\":").append(buildBoardOnly(game))
		.append('}');
    	
    	return builder.toString();
    }
    
    public static String buildBoardOnly(GameSession game){
    	StringBuilder builder = new StringBuilder();
    	
    	int[][] board1,board2,board3;
    	
    	builder = builder.append('{');
    	for (int i = 0; i < 3; i++){
    		// get each row of subgames
    		board1 = game.getCurrentGame().GetSubBoard(0, i);
    		board2 = game.getCurrentGame().GetSubBoard(1, i);
    		board3 = game.getCurrentGame().GetSubBoard(2, i);
    		// get each row of integers in the row of subgames
    		builder = builder.append('{');
    		for (int j = 0; j < 3; j++){
    			builder = builder.append(buildRow(board1,j)).append(',')
    			.append(buildRow(board2,j)).append(',')
    			.append(buildRow(board3,j));
    		}
    		builder = builder.append('}');
    		if (i<2){
    			builder = builder.append(',');
    		}
    	}
    	builder.append('}');
    	
    	return builder.toString();
    }
    
    public static String buildRow(int[][] board, int rownumber){
    	StringBuilder builder = new StringBuilder();
    	
    	for (int i = 0; i < 3; i++){
    		builder = builder.append("\"Integer.toString(board[i][rownumber])\"");
    		if (i<2){
    			builder = builder.append(',');
    		}
    	}
    	
    	return builder.toString();
    }
}
