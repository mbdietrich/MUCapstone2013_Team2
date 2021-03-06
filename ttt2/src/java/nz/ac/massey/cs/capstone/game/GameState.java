/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.game;

//GameState keeps track of the nested tic-tac-toe state.
//Players: 0=not taken, 1=X, 2=O
//TODO: Store previous moves so it can be replayed.
// TODO: isDone() method
public class GameState {
	
	private int CurrentPlayer; // 1 = Player 1 (X), 2 = Player 2 (O)
	protected SubGame SelectedSubgame;
	private SubGame[][] mainboard;
	private int[][] statusboard; // contains the STATUSES ONLY of the subgames in mainboard
	private int winner;
	
	/**
	 * Constructor. 
	 * Initializes the variables and creates the empty subgames.
	 */
    public GameState() {
    	//TODO: Better selection for the starting player? i.e. Random, or winner of last game
    	winner = 0;
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
    
    public GameState(int[][][][] data){
        winner = 0;
        CurrentPlayer = 1;
        mainboard = new SubGame[3][3];
        statusboard = new int[3][3];
        for (int i=0; i<3; i++){
			for (int j =0; j<3; j++){
				mainboard[i][j]= new SubGame(data[i][j]);
				statusboard[i][j] = GameRules.checkStatusBoard(data[i][j]);
			}
		}
    }
    
    /**
     * Place a new piece on the board
     * @param newMove A object of the Coordiantes class to determine where a piece is to be played.
     */
    public void PlacePiece(Coordinates newMove, int player){
    	// Get subgame from the right section.
    	SelectedSubgame = mainboard[newMove.outerX][newMove.outerY];
    	
		//Set the player's piece
		SelectedSubgame.setGamePiece(newMove.innerX, newMove.innerY, player);
		
		//Is the subgame now finished?
		int subwinner = findWinner(SelectedSubgame.getBoard());
		if (subwinner !=0){
			SelectedSubgame.setStatus(subwinner); // if the game is now closed, set the new subgame status
			
			//Update the statusboard and check that for an overall winner
			statusboard[newMove.outerX][newMove.outerY] = subwinner;
			if (findWinner(statusboard)!=0){
				//Set the winner. 
				winner = findWinner(statusboard);
			}
		}
		nextTurn();
    }
    
    /**
     * Change players
     */
    private void nextTurn(){
    	if (CurrentPlayer == 1) CurrentPlayer = 2;
    	if (CurrentPlayer == 2) CurrentPlayer = 1;
    }
    
	/**
	 * Finds the winner of the game/subgame.
	 * This should be called after every valid move is placed.
	 * @param board A 3-by-3 array containing integer elements to represent the current state of the board. 0 = unused space; 1 = Player 1 (X); 2 = Player 2 (O).
	 * @return 0 if the game is still open; 1 if Player 1 (X) has won; 2 if Player 2 (O) has won; 3 if the game has tied (No more valid spaces and no winner).
	 */
	public static int findWinner(int[][] board){
            return GameRules.checkStatusBoard(board);
	}
		
	
	
	// ****** Getters and Setters ******
    
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
         * gets the current Statusboard.
         * @return statusboard a 3-by-3 array that contains the status of the subGames.
         */
	public int[][] getStatusboard() {
		return statusboard;
	}

        /**
         * gets the current mainboard.
         * @return mainboard a 3-by-3 array that contains the subGames.
         */
	public SubGame[][] getMainboard() {
		return mainboard;
	}

        /**
         * gets the current player.
         * @return currentPlayer An object of type Player.
         */
	public int getCurrentPlayer() {
		return CurrentPlayer;
	}

        /**
         * gets the winner of the board.
         * @return winner An object of type Player.
         */
	public int getWinner() {
		return winner;
	}    

}
