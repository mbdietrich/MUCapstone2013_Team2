/*
 * @author Ryan
 * Version 0.1
 */
package nz.ac.massey.cs.capstone.player;
import nz.ac.massey.cs.capstone.game.SubGame;
import nz.ac.massey.cs.capstone.game.Coordinates;
import nz.ac.massey.cs.capstone.game.GameRules;
import nz.ac.massey.cs.capstone.game.GameState;
import java.util.*;

public class GameBot extends Bot
{
    /**
     * Decides which piece the bot will play next.
     * @param prev the current GameState before the bot makes a move.
     * @param player the player the bot is (either 1 or 2).
     * @return Coordinates of the bots next move.
     */
    //@Override
    public Coordinates next2(GameState prev, int player)
    {
        Random random = new Random();
        ArrayList<Coordinates> posMoves = new ArrayList<Coordinates>();
        for (int x = 0; x < 3; x++)
        {
            for (int y = 0; y < 3; y++)
            {
                for (int i = 0; i < 3; i++)
                {
                    for (int j = 0; j < 3; j++)
                    {
                        Coordinates coord = new Coordinates(x,y,i,j);
                        if (GameRules.validMove(prev, coord))
                        {
                            posMoves.add(coord);
                        }
                    }
                }
            }
        }
        int move = random.nextInt(posMoves.size());
        return posMoves.get(move);
    }
    
    @Override
    public Coordinates next(GameState prev, int player)
    {
        Coordinates newMove = new Coordinates(0,0,0,0);
        Coordinates tempMove = new Coordinates(0,0,0,0);
        int opPlayer = 0;
        if (player == 1)
        {
            opPlayer = 2;
        }
        else if (player == 2)
        {
            opPlayer = 1;
        }
        
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                SubGame subBoard = prev.GetSubGame(i, j);
                Coordinates posMove = checkSubGame(subBoard, opPlayer);
                if (posMove.getInnerX() != 3)
                {
                    Coordinates posMove2 = checkSubGame(subBoard, player);
                    if (posMove2.getInnerX()!= 3)
                    {
                        tempMove.setOuterX(i);
                        tempMove.setOuterY(j);
                        tempMove.setInnerX(posMove2.getInnerX());
                        tempMove.setInnerY(posMove2.getInnerY());
                        if (GameRules.validMove(prev, tempMove))
                        {
                            return tempMove;
                        }
                    }
                    tempMove.setOuterX(i);
                    tempMove.setOuterY(j);
                    tempMove.setInnerX(posMove.getInnerX());
                    tempMove.setInnerY(posMove.getInnerY());
                    if (GameRules.validMove(prev, tempMove))
                    {
                        return tempMove;
                    }
                }
            }
        }
        
        //Do something else
        int[][] bigBoard = prev.getStatusboard();
        
        Coordinates tempCoord2 = subGameMove(bigBoard);
        newMove.setOuterX(tempCoord2.getInnerX());
        newMove.setOuterY(tempCoord2.getInnerY());
        
        int[][] game = prev.GetSubBoard(tempCoord2.getInnerX(), tempCoord2.getInnerY());
        
        Coordinates tempCoord3 = subGameMove(game);
        newMove.setInnerX(tempCoord3.getInnerX());
        newMove.setInnerY(tempCoord3.getInnerY());

        return newMove;
    }
    
    private Coordinates checkSubGame(SubGame game, int opPlayer)
    {
        Coordinates coord = new Coordinates(0,0,3,0);
        int[][] board = game.getBoard();
        
        if (board[0][0] == opPlayer && board[1][0] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(0);
        }
        else if (board[1][0] == opPlayer && board[2][0] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(0);
        }
        else if (board[0][0] == opPlayer && board[2][0] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(0);
        }
        else if (board[0][1] == opPlayer && board[1][1] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(1);
        }
        else if (board[1][1] == opPlayer && board[2][1] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(1);
        }
        else if (board[0][1] == opPlayer && board[2][1] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(1);
        }
        else if (board[0][2] == opPlayer && board[1][2] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(2);
        }
        else if (board[1][2] == opPlayer && board[2][2] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(2);
        }
        else if (board[0][2] == opPlayer && board[2][2] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(2);
        }
        else if (board[0][0] == opPlayer && board[0][1] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(2);
        }
        else if (board[0][1] == opPlayer && board[0][2] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(0);
        }
        else if (board[0][0] == opPlayer && board[0][2] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(1);
        }
        else if (board[1][0] == opPlayer && board[1][1] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(2);
        }
        else if (board[1][1] == opPlayer && board[1][2] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(0);
        }
        else if (board[1][0] == opPlayer && board[1][2] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(1);
        }
        else if (board[2][0] == opPlayer && board[2][1] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(2);
        }
        else if (board[2][1] == opPlayer && board[2][2] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(0);
        }
        else if (board[2][0] == opPlayer && board[2][2] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(1);
        }
        else if (board[0][0] == opPlayer && board[1][1] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(2);
        }
        else if (board[1][1] == opPlayer && board[2][2] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(0);
        }
        else if (board[0][0] == opPlayer && board[2][2] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(1);
        }
        else if (board[2][0] == opPlayer && board[1][1] == opPlayer)
        {
            coord.setInnerX(0);
            coord.setInnerY(2);
        }
        else if (board[1][1] == opPlayer && board[0][2] == opPlayer)
        {
            coord.setInnerX(2);
            coord.setInnerY(0);
        }
        else if (board[2][0] == opPlayer && board[0][2] == opPlayer)
        {
            coord.setInnerX(1);
            coord.setInnerY(1);
        }
        return coord;
    }
    
    private Coordinates subGameMove(int[][] board)
    {
        Coordinates coord = new Coordinates(0,0,0,0);
        //int[][] board = game.getBoard();
        
        if (board[1][1] == 0)
        {
            coord.setInnerX(1);
            coord.setInnerY(1);
        }
        else if (board[0][0] == 0)
        {
            coord.setInnerX(0);
            coord.setInnerY(0);
        }
        else if (board[2][2] == 0)
        {
            coord.setInnerX(2);
            coord.setInnerY(2);
        }
        else if (board[2][1] == 0)
        {
            coord.setInnerX(2);
            coord.setInnerY(1);
        }
        else if (board[1][0] == 0)
        {
            coord.setInnerX(1);
            coord.setInnerY(0);
        }
        else if (board[1][2] == 0)
        {
            coord.setInnerX(1);
            coord.setInnerY(2);
        }
        else if (board[2][0] == 0)
        {
            coord.setInnerX(2);
            coord.setInnerY(0);
        }
        else if (board[0][2] == 0)
        {
            coord.setInnerX(0);
            coord.setInnerY(2);
        }
        else if (board[0][1] == 0)
        {
            coord.setInnerX(0);
            coord.setInnerY(1);
        }
        return coord;
    }
    /**
     * returns the game of the bot.
     * @return "Default Bot" A String of the name of the bot.
     */
    @Override
    public String getName() {
        return "DefaultBot";
    }
}