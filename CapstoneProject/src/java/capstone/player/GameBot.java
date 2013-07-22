/*
 * @author Ryan
 * Version 0.1
 */
package capstone.player;
import capstone.game.*;
import java.util.*;

public class GameBot 
{
    /**
     * 
     * @param state the current game state before the bot makes a move.
     * @param lastMove the last move the other player made so the bot knows which sub-game the next move should be made in.
     * @param player the player the bot is (either 1 or 2).
     * @return GameState after the bot has made its move.
     */
    public GameState makeMove(GameState state, Coordinates lastMove, int player)
    {
        Random random = new Random();
        GameState.Subgame subgame = state.getSubgame(lastMove.getInnerX(), lastMove.getInnerY());
        //If the nested game that the bot is supposed to play in next is complete, they can choose any one of the nested games available.
        if (subgame.isDone())
        {
            ArrayList<Coordinates> outerGameCoords = new ArrayList<Coordinates>();
            for (int x = 0; x < 3; x++)
            {
                for (int y = 0; y < 3; y++)
                {
                    GameState.Subgame game2 = state.getSubgame(x, y);
                    if (!game2.isDone())
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
            subgame = state.getSubgame(x, y);
        }
        
        //Check for all empty places in the subgame, and choose one randomly to play in.
        ArrayList<Coordinates> innerGames = new ArrayList<Coordinates>();
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                if (subgame.getValue(i, j) == 0)
                {
                    Coordinates coord = new Coordinates(0, 0, i, j);
                    innerGames.add(coord);
                }
            }
        }
        int innerGameCoords = random.nextInt(innerGames.size());
        Coordinates moveCoords = innerGames.get(innerGameCoords);
        int i = moveCoords.getInnerX();
        int j = moveCoords.getInnerY();
        subgame.setValue(i, j, player);
        return state;
    }
}