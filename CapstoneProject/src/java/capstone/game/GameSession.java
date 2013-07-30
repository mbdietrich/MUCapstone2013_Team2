
package capstone.game;

import capstone.player.*;
import java.util.UUID;

public class GameSession {

	private GameState currentgame;
	private Player player1, player2, currentPlayer, gameWinner;

        public final String SessionID = UUID.randomUUID().toString();
        
	/**
	 * Constructor.
	 */
	public GameSession() {
		/*
		 * TODO: When both players are ready, create the GameState. While the game is
		 * not finished, prompt the player for a move When the game is finished,
		 * display a message
		 */
	}

	public void Join(Player player) throws IllegalGameException {
		if(player1==null){
                    player1=player;
                }
                else if(player2==null){
                    player2=player;
                }
                else throw new IllegalGameException("Player "+player.toString()+" tried to join a full game.");
	}
	
	public void Play(){
		//Get the current player's move
		Coordinates newMove = new Coordinates(0,0,0,0);
		switch(currentgame.getCurrentPlayer()){
		case 1: newMove = player1.next(currentgame, 1);
				currentPlayer = player1;
				break;
		case 2: newMove = player2.next(currentgame, 2);
				currentPlayer = player2;
				break;
		}
		
		if (GameRules.validMove(currentgame, newMove)){
			// if this move is valid
			currentgame.PlacePiece(newMove);
		}
		else {
			//if this move is not valid, the player is forced out for now
			Leave(currentPlayer);
		}
		if (!GameRules.isDone(currentgame)){
			//if the game is not finished, call the function again
			Play();
		}
		else{
			//TODO: if the game is finished, update the properties
		}
	}

	public void Leave(Player player) {
		/*
		 * Used by a player to leave the game
		 */
	}

}
