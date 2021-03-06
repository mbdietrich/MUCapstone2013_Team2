 /**
 * This class contains the methods used to implement the main rules of the game
 * @author Sarsha Jones
 * @version 0.1
 */
package nz.ac.massey.cs.capstone.game;

public class GameRules {
		
	/**
	 * Checks if a player has won. Returns 0 if no winner exists.
	 * @param board The GameState which is being checked for a winner.
	 * @return 1 or 2, if player 1 or 2 won the game, or 0 if there is no winner.
	 */
	public static int findWinner(GameState board){
            int[][] statusboard = board.getStatusboard();
            return checkStatusBoard(statusboard);
	}

        /**
         * Checks board to see if a player has won a game.
         * @param board A 3-by-3 array of the superGames values.
         * @return the number of the player who won or 0 if draw.
         */
        public static int checkStatusBoard(int[][] board) {
            int returnValue = 0;
            if(board[0][0] == board[1][0] && board[0][0] == board[2][0]) {
                if(board[0][0] == 1 || board[0][0] == 2) {
                    return board[0][0];
                }
            }
            if (board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
                if(board[0][0] == 1 || board[0][0] == 2) {
                    return board[0][0];
                }
            }
            if (board[0][0] == board[0][1] && board[0][0] == board[0][2]) {
                if(board[0][0] == 1 || board[0][0] == 2) {
                    return board[0][0];
                }
            }
            if (board[1][0] == board[1][1] && board[1][0] == board[1][2]) {
                if(board[1][0] == 1 || board[1][0] == 2) {
                    return board[1][0];
                }
            }
            if (board[2][0] == board[2][1] && board[2][0] == board[2][2]) {
                if(board[2][0] == 1 || board[2][0] == 2) {
                    return board[2][0];
                }
            }
            if (board[2][0] == board[1][1] && board[2][0] == board[0][2]) {
                if(board[2][0] == 1 || board[2][0] == 2) {
                    return board[2][0];
                }
            }
            if (board[0][1] == board[1][1] && board[0][1] == board[2][1]) {
                if(board[0][1] == 1 || board[0][1] == 2) {
                    return board[0][1];
                }
            }
            if (board[0][2] == board[1][2] && board[0][2] == board[2][2]) {
                if(board[0][2] == 1 || board[0][2] == 2) {
                    return board[0][2];
                }
            }
            if (returnValue == 0)
            {
                if (checkForDraw(board))
                {
                    returnValue = 3;
                }
            }
            return returnValue;
        }

        public static boolean checkForDraw(int[][] board)
        {
            for (int x = 0; x < 3; x++)
            {
                for (int y = 0; y < 3; y++)
                {
                    if (board[x][y] == 0)
                        return false;
                }
            }
            return true;
        }

        /**
         * Checks if board is complete.
         * @param board The GameState being checked.
         * @return True if board is done, false otherwise.
         */
        public static boolean isDone(GameState board){
            //Assumes player can play on a subgame that has already been won
            int[][] statusBoard = board.getStatusboard();
            if (checkStatusBoard(statusBoard) != 0)
            {
                return true;
            }
            return false;
        }

        /**
         * Checks to see if the subGame board if finished.
         * @param board The subGame being checked.
         * @return true if board's status is 1 or 2, false if 0.
         */
        private static boolean checkSubBoard(SubGame board) {
            if(board.getStatus() == 0) {
                return false;
            } else {
                return true;
            }
        }
	
	/**
	 * Checks if the next move is valid.
	 * @param board The current GameState.
         * @param move The Coordinates being checked.
	 * @return true if the move is valid or false if not.
	 */
	public static boolean validMove(GameState board, Coordinates move){
            if(move==null||board==null){
                return false;
            }
                SubGame subgame = board.GetSubGame(move.getOuterX(), move.getOuterY());
                int position = subgame.getGamePiece(move.getInnerX(), move.getInnerY());
                if ((position == 0)&&(subgame.getStatus()==0)) {
                	// Subgame is open and the location is empty
                    return true;
                }
                else {
                    return false;
                }
	}
        
        

}
