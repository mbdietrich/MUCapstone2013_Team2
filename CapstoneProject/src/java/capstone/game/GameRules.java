/**
 * This class contains the methods used to implement the main rules of the game
 * @author Sarsha Jones
 * @version 0.1
 */
package capstone.game;

public class GameRules {
		
	/**
	 * Checks if a player has won. Returns 0 if no winner exists.
	 * @param board
	 * @return
	 */
	public static int findWinner(GameState board){
		//TODO: Find and implement the algorithm for this.
            int[][] statusboard = board.getStatusboard();
            return checkStatusBoard(statusboard);
	}
        
        private static int checkStatusBoard(int[][] board) {
            int returnValue = 0;
            if(board[0][0] == board[1][0] && board[0][0] == board[2][0]) {
                returnValue = board[0][0];
            } else if (board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
                returnValue = board[0][0];
            } else if (board[0][0] == board[0][1] && board[0][0] == board[0][2]) {
                returnValue = board[0][0];
            } else if (board[1][0] == board[1][1] && board[1][0] == board[1][2]) {
                returnValue = board[1][0];
            } else if (board[2][0] == board[2][1] && board[2][0] == board[2][2]) {
                returnValue = board[2][0];
            } else if (board[2][0] == board[1][1] && board[2][0] == board[0][2]) {
                returnValue = board[2][0];
            } else if (board[0][1] == board[1][1] && board[0][1] == board[2][1]) {
                returnValue = board[0][1];
            } else if (board[0][2] == board[1][2] && board[0][2] == board[2][2]) {
                returnValue = board[0][2];
            }
            return returnValue;
        }
        
        public static boolean isDone(GameState board){
            //Assumes player can play on a subgame that has already been won
            for(int x=0;x<3;x++) {
                for(int y=0;y<3;y++) {
                    if(checkSubBoard(board.GetSubGame(x, y))) {
                        return true;
                    }
                }
            }
            return false;
        }
        
        private static boolean checkSubBoard(SubGame board) {
            if(board.getStatus() == 0) {
                return false;
            } else {
                return true;
            }
        }
	
	/**
	 * Checks if the next move is valid.
	 * @param board
	 * @return
	 */
	public static boolean validMove(GameState board, Coordinates move){
                SubGame subgame = board.GetSubGame(move.getOuterX(), move.getOuterY());
                int position = subgame.getGamePiece(move.getInnerX(), move.getInnerY());
                if (position == 0) {
                    return true;
                }
                else {
                    return false;
                }
	}
        
        

}
