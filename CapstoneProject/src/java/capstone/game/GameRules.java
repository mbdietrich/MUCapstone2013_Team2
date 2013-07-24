/**
 * This class contains the methods used to implement the main rules of the game
 * @author Sarsha Jones
 * @version 0.1
 */
package capstone.game;

public class GameRules {
		
	/**
	 * Finds the winner of the game/subgame.
	 * This should be called after every valid move is placed.
	 * 
	 * @param board A 3-by-3 array containing integer elements to represent the current state of the board. 0 = unused space; 1 = Player 1 (X); 2 = Player 2 (O).
	 * @return 0 if the game is still open; 1 if Player 1 (X) has won; 2 if Player 2 (O) has won; 3 if the game has tied (No more valid spaces and no winner).
	 */
	public static int findWinner(GameState board){
		//TODO: Find and implement the algorithm for this.
		return 0;
	}
	
	/**
	 * Checks if the subgame is valid. This means the difference in the number of X tokens and O tokens on the board 
	 * is not greater than one.
	 * @param board
	 * @return
	 */
	public static boolean validSubgame(GameState board){
		// TODO: implement this. + Other things to check?
		return true;
	}

}
