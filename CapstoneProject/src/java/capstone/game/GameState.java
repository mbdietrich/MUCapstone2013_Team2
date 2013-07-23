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
	protected SuperGame CurrentGame;
	protected SubGame SelectedSubgame;
	
	/**
	 * Constructor. Initializes the variables and the games
	 */
    public GameState() {
    	CurrentGame = new SuperGame();
    	//TODO: Better selection for the starting player? i.e. Random, or winner of last game
    	CurrentPlayer = 1;
    }
    
    public void PlacePiece(int superGameX, int superGameY, int subGameX, int subGameY){
    	/*TODO: Better way to pass in variables? Such as using section 'A' and subgame 'B' instead of 2 pairs of co-ordinates
    	 * e.g. instead of supergame [0,2] and subgame [1,0], it would be section 7 and subgame 2
    	 */
    	
    	// Get subgame from the right section.
    	SelectedSubgame = CurrentGame.GetSubGame(superGameX, superGameY);
    	//TODO: Throw an exception if the subgame is closed? at the moment, the move is simply ignored.
    	if (SelectedSubgame.getStatus() == 0){
			//Set the player's piece (validity will be checked in the subgame class)
			SelectedSubgame.setGamePiece(subGameX, subGameY, CurrentPlayer);
			CurrentGame.setStatusboard(superGameX, superGameY);
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

	public int getCurrentPlayer() {
		return CurrentPlayer;
	}

	public void setCurrentPlayer(int currentPlayer) {
		CurrentPlayer = currentPlayer;
	}

	public SuperGame getCurrentGame() {
		return CurrentGame;
	}

	public void setCurrentGame(SuperGame currentGame) {
		CurrentGame = currentGame;
	}

	public SubGame getSelectedSubgame() {
		return SelectedSubgame;
	}

	public void setSelectedSubgame(SubGame selectedSubgame) {
		SelectedSubgame = selectedSubgame;
	}
    
    

}
