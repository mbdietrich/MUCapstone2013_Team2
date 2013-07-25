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

	public void Join() {
		/*
		 * Used by a player to join the game
		 */
	}

	public void Leave() {
		/*
		 * Used by a player to leave the game
		 */
	}

}
