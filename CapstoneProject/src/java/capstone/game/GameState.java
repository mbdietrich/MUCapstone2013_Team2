/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

//GameState keeps track of the nested tic-tac-toe state.
//Players: 0=not taken, 1=X, 2=O
public class GameState {

    //A subgame is a 3x3 board. GameState has a 3x3 grid of subgames.
    public static class Subgame {

        private int[][] board = new int[3][3];

        public int getValue(int x, int y) {
            return board[x][y];
        }

        public void setValue(int x, int y, int player) {
            //TODO perhaps throw an exception if the move is invalid?
            board[x][y] = player;
        }

        public boolean isDone() {
            //TODO is the subgame done eg. is there a winner/any valid moves left?
            return false;
        }

        public int Winner() {
            //TODO return 0 if draw/unfinished, otherwise the winning player.
            return 0;
        }
    }
    private Subgame[][] board;

    public GameState() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                board[i][j] = new Subgame();
            }
        }
    }
    

    public boolean isDone() {
        //TODO is the subgame done eg. is there a winner/any valid moves left?
        return false;
    }

    public int Winner() {
        //TODO return 0 if draw/unfinished, otherwise the winning player.
        return 0;
    }
    
    public Subgame getSubgame(int x, int y)
    {
        return board[x][y];
    }

}
