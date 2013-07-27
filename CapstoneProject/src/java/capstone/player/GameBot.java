/*
 * @author Ryan
 * Version 0.1
 */
package capstone.player;
import capstone.game.*;
import java.util.*;

public class GameBot implements Player
{
    /**
     * 
     * @param state the current game state before the bot makes a move.
     * @param player the player the bot is (either 1 or 2).
     * @return GameState after the bot has made its move.
     */
    @Override
    public Coordinates next(GameState prev, int player)
    {
        Random random = new Random();
        Coordinates chosenMove = new Coordinates(0,0,0,0);
        int firstX = random.nextInt(3);
        int firstY = random.nextInt(3);
        SubGame subgame = prev.GetSubGame(firstX, firstY);
        //If the nested game that the bot is supposed to play in next is complete, they can choose any one of the nested games available.
        if (subgame.getStatus() != 0)
        {
            ArrayList<Coordinates> outerGameCoords = new ArrayList<Coordinates>();
            for (int x = 0; x < 3; x++)
            {
                for (int y = 0; y < 3; y++)
                {
                    SubGame game2 = prev.GetSubGame(x, y);
                    if (game2.getStatus() == 0)
                    {
                        Coordinates coord = new Coordinates(x, y, 0, 0);
                        outerGameCoords.add(coord);
                    }
                }
            }
            int chosenCoords = random.nextInt(outerGameCoords.size());
            Coordinates gameCoords = outerGameCoords.get(chosenCoords);
            int x = gameCoords.getOuterX();
            int y = gameCoords.getOuterY();
            subgame = prev.GetSubGame(x, y);
            chosenMove.setOuterX(x);
            chosenMove.setOuterY(y);
        }
        
        //Check for all empty places in the subgame, and choose one randomly to play in.
        ArrayList<Coordinates> innerGames = new ArrayList<Coordinates>();
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                if (subgame.getGamePiece(i, j) == 0)
                {
                    Coordinates coord = new Coordinates(0, 0, i, j);
                    innerGames.add(coord);
                }
            }
        }
        int innerGameCoords = random.nextInt(innerGames.size());
        Coordinates moveCoords = innerGames.get(innerGameCoords);
        int innerX = moveCoords.getInnerX();
        int innerY = moveCoords.getInnerY();
        chosenMove.setInnerX(innerX);
        chosenMove.setInnerY(innerY);
        return chosenMove;
    }
}