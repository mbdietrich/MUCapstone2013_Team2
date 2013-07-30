
package capstone.game;

import capstone.player.*;
import java.util.UUID;

public class GameSession {

	private GameState currentgame;
	private Player player1, player2;

        public final String SessionID = UUID.randomUUID().toString();
        
	/**
	 * Constructor.
	 */
	public GameSession() {
		/*
		 * When both players are ready, create the GameState. While the game is
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

	public void Leave(Player player) {
		/*
		 * Used by a player to leave the game
		 */
	}

}
