
package capstone.game;

import capstone.player.*;
import java.util.UUID;

public class GameSession {

	private GameState currentgame=new GameState();
	private Player player1, player2, currentPlayer, gameWinner;

        public final String SessionID = UUID.randomUUID().toString();
        
        public GameState getCurrentGame(){
            return currentgame;
        }
        
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
                    currentPlayer=player1;
                }
                else if(player2==null){
                    player2=player;
                }
                else throw new IllegalGameException("Player "+player.toString()+" tried to join a full game.");
	}
	
        //Called by the players to register a move
        //Make sure it's the player's move
        //Make sure move is valid, then set the game state
        //If the game is not done, call notify on the next player
        public void move(Player player, Coordinates move){
            //TODO implement
            if (player == this.currentPlayer) {
                if (GameRules.validMove(currentgame, move)) {
                    currentgame.PlacePiece(move);
                    if (currentPlayer == player1) {
                        currentPlayer = player2;
                    }
                    else if (currentPlayer == player2) {
                        currentPlayer = player1;
                    }
                    if (!GameRules.isDone(currentgame)) {
                        currentPlayer.notify(this);
                    }
                }
            }
        }
        
        //what's my player number?
        public int getPlayerNumber(Player player){
            if (player == player1) {
                return 1;
            }
            else {
                return 2;
            }

        }

	public void Leave(Player player) {
		/*
		 * Used by a player to leave the game
		 */
	}

}
