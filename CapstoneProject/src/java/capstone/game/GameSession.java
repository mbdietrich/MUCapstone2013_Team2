
package capstone.game;

import capstone.player.*;
import java.util.UUID;

public class GameSession {

	private GameState currentgame=new GameState();
	private Player player1, player2, currentPlayer, gameWinner;

        public final String SessionID = UUID.randomUUID().toString();

        /**
         * gets the current GameState.
         * @return currentgame The current GameState.
         */
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

        /**
         * Given a player, Join will either put that player in the game, or throw an
         * IllegalGameException if the game is full.
         * @param player The Player who is trying to join the game.
         * @throws IllegalGameException If the game is full.
         */
	public void Join(Player player) throws IllegalGameException {
		if(player1==null){
                    player1=player;
                    currentPlayer=player1;
                }
                else if(player2==null){
                    player2=player;
                    currentPlayer.notify(this);
                }
                else throw new IllegalGameException("Player "+player.toString()+" tried to join a full game.");
	}
        
        public boolean isOpen(){
            return player1==null||player2==null;
        }
	
        //Called by the players to register a move
        //Make sure it's the player's move
        //Make sure move is valid, then set the game state
        //If the game is not done, call notify on the next player
        /**
         * Given a player and their move it will check that the move is valid, and then
         * place the move on the board and change the current player to the next player.
         * @param player the Player who is making the move.
         * @param move Coordinates of where the move is to be placed.
         */
        public void move(Player player, Coordinates move){
            //TODO implement
            int playerInt;
            if (player == this.currentPlayer) {
                if (GameRules.validMove(currentgame, move)) {
                    if (currentPlayer.equals(player1)) {
                        playerInt = 1;
                    }
                    else{
                        playerInt = 2;
                    }
                    currentgame.PlacePiece(move, playerInt);
                    
                    if (currentPlayer.equals(player1)) {
                        currentPlayer = player2;
                    }
                    else if (currentPlayer.equals(player2)) {
                        currentPlayer = player1;
                    }
                    if (!GameRules.isDone(currentgame)) {
                        currentPlayer.notify(this);
                    }
                }
                else{
                	this.Leave(currentPlayer);
                }
            }
            
        }
        
        //what's my player number?
        /**
         * Gets the number of the player, either 1 or 2.
         * @param player The Player who wants to get their number.
         * @return Either 1 or 2 depending on which number player the Player is.
         */
        public int getPlayerNumber(Player player){
            if (player.equals(player1)) {
                return 1;
            }
            else {
                return 2;
            }

        }

        /**
         * Used by a player to leave the game.
         * @param player The Player who is leaving the game.
         */
	public void Leave(Player player) {
		/*
		 * Used by a player to leave the game
		 */
            if (player.equals(player1)) {
                player1 = null;
                gameWinner = player2;
            }
            else if (player.equals(player2)) {
                player2 = null;
                gameWinner = player1;
            }
	}
        
        /**
         * Returns the current player.
         * @return currentPlayer
         */
        public Player getCurrentPlayer()
        {
            return currentPlayer;
        }
        
        /**
         * gets the game winner if there is one.
         * @return gameWinner
         */
        public Player getGameWinner()
        {
            return gameWinner;
        }

}
