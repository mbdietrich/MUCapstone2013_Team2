/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

//GameState keeps track of the nested tic-tac-toe state.
//Players: 0=not taken, 1=X, 2=O
//TODO: Store previous moves so it can be replayed.
public class GameState {
	
	private int CurrentPlayer; // 1 = Player 1 (X), 2 = Player 2 (O)
	protected SubGame SelectedSubgame;
	private SubGame[][] mainboard;
	private int[][] statusboard; // contains the STATUSES ONLY of the subgames in mainboard
	
	/**
	 * Constructor. 
	 * Initializes the variables and creates the empty subgames.
	 */
    public GameState() {
    	//TODO: Better selection for the starting player? i.e. Random, or winner of last game
    	CurrentPlayer = 1;
		mainboard = new SubGame[3][3];
		statusboard = new int[3][3];
		for (int i=0; i<3; i++){
			for (int j =0; j<3; j++){
				mainboard[i][j]= new SubGame();
				statusboard[i][j] = 0;
			}
		}
    }
    
    public void PlacePiece(int superGameX, int superGameY, int subGameX, int subGameY){
    	/*TODO: Better way to pass in variables? Such as using section 'A' and subgame 'B' instead of 2 pairs of co-ordinates
    	 * e.g. instead of supergame [0,2] and subgame [1,0], it would be section 7 and subgame 2
    	 */
    	
    	// Get subgame from the right section.
    	SelectedSubgame = mainboard[superGameX][superGameY];
    	//TODO: Throw an exception if the subgame is closed? at the moment, the move is simply ignored.
    	if (SelectedSubgame.getStatus() == 0){
			//Set the player's piece (validity will be checked in the subgame class)
			SelectedSubgame.setGamePiece(subGameX, subGameY, CurrentPlayer);
			setStatusboard(superGameX, superGameY);
			nextTurn();
    	}
    }
    
    /**
     * Change players
     */
    private void nextTurn(){
    	if (CurrentPlayer == 1) CurrentPlayer = 2;
    	if (CurrentPlayer == 2) CurrentPlayer = 1;
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
		mainboard[x][y].setStatus(GameRules.findWinner(newsubboard));
	}
	
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
			if (GameRules.findWinner(statusboard)!= 0){
				//TODO: Game is complete! What now?
			}
		}
	}

	public SubGame[][] getMainboard() {
		return mainboard;
	}

	public void setMainboard(SubGame[][] mainboard) {
		this.mainboard = mainboard;
	}

	public int getCurrentPlayer() {
		return CurrentPlayer;
	}

	public void setCurrentPlayer(int currentPlayer) {
		CurrentPlayer = currentPlayer;
	}


	public SubGame getSelectedSubgame() {
		return SelectedSubgame;
	}

	public void setSelectedSubgame(SubGame selectedSubgame) {
		SelectedSubgame = selectedSubgame;
	}
    
    

}
