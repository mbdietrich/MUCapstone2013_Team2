/**
 * This is the class for the top-level board. It contains the subgames inside it (which have their own class), 
 * arranged in a 3 x 3 array.
 * @author Sarsha Jones
 * @version 0.1
 */
package capstone.game;

public class SuperGame {
	
	private SubGame[][] mainboard;
	private int[][] statusboard; // contains the STATUSES ONLY of the subgames in mainboard
	
	/**
	 * Constructor.
	 * Creates the top-level board which is filled with 9 empty subgames.
	 */
	public SuperGame(){
		// Initialization
		mainboard = new SubGame[3][3];
		statusboard = new int[3][3];
		for (int i=0; i<3; i++){
			for (int j =0; j<3; j++){
				mainboard[i][j]= new SubGame();
				statusboard[i][j] = 0;
			}
		}
	}

	/**
	 * This returns the subgame in the specified location.
	 * NOTE: This returns a variable of the SUBGAME class. To get the board as a 2D array only, use GetSubBoard().
	 * @param x Column (0 - 2)
	 * @param y Row (0 - 2)
	 * @return The SubGame variable stored in the given location of the main game
	 */
	public SubGame GetSubGame(int x, int y){
		return mainboard[x][y];
	}
	
	/**
	 * This returns the subgame in the specified location.
	 * NOTE: This returns the subgame as a 2D array. To get the board as a SUBGAME variable (which includes the 
	 * game's status), use GetSubGame().
	 * @param x Column of the top-level board (0 - 2)
	 * @param y Row of the top-level board (0 - 2)
	 * @return The board stored in the SubGame of the given location.
	 */
	public int[][] GetSubBoard(int x, int y){
		return mainboard[x][y].getBoard();
	}
	
	/**
	 * This replaces the subgame in the given location with the subgame passed into the method.
	 * NOTE: This requires you to have a SUBGAME variable, complete with the correct(!!) "status" property. 
	 * If you only have an integer array, use SetSubBoard().
	 * @param x Column of the top-level board (0 - 2)
	 * @param y Row of the top-level board (0 - 2)
	 * @param newsubgame The new subgame to replace the current one in the given location
	 */
	public void SetSubGame(int x, int y, SubGame newsubgame){
		//TODO: check validity of the board
		mainboard[x][y] = newsubgame;
	}
	
	/**
	 * This replaces the subgame in the given location with the game passed into the method.
	 * NOTE: This only requires the board as a 3 x 3 array of integers (assuming the correct representation
	 * of the board with 0s, 1s and 2s). The status of the board is not needed. If you already have a SUBGAME 
	 * variable, use SetSubGame().
	 * @param x Column of the top-level board (0 - 2)
	 * @param y Row of the top-level board (0 - 2)
	 * @param newsubboard The new 3 x 3 integer array to replace the board in the given location
	 */
	public void SetSubBoard(int x, int y, int[][] newsubboard){
		//TODO: check validity of the board
		mainboard[x][y].setBoard(newsubboard);
                //FIXME
                    //mainboard[x][y].setStatus(GameRules.findWinner(newsubboard));
	}

	/**
	 * Returns an array representing the winners of the individual subgames. Because this is in the same format as
	 * the subgame boards, the same method can be used to check for the result of the supergame as well as the subgames.
	 * @return 2D int array showing the status of all the subgames. 0 = subgame is still in play (open); 1 = subgame won by Player 1 (X), 2 = subgame won by Player 2(O), 3 = Tied (no empty spaces and no winner)
	 */
	public int[][] getStatusboard() {
		return statusboard;
	} 
	
	/**
	 * Update the statusboard for a given subgame. If there has been a change, check to see if there is an overall winner.
	 * @param x Column of the top-level board (0 - 2)
	 * @param y Row of the top-level board (0 - 2)
	 */
	public void setStatusboard(int x, int y){
		if (statusboard[x][y] != mainboard[x][y].getStatus()){
			// A subgame has been completed.  update the statusboard
			statusboard[x][y] = mainboard[x][y].getStatus();
			// Is there a winner yet?
                        
                        //FIXME 
                            //if (GameRules.findWinner(statusboard)!= 0){
                            //	//TODO: Game is complete! What now?
                            //}
		}
	}
}
