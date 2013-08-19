/*
 * @author Ryan
 * Version 0.1
 */
package capstone.player;
import capstone.game.*;
import java.util.*;

public class GameBot extends Bot
{
    /**
     * Decides which piece the bot will play next.
     * @param prev the current GameState before the bot makes a move.
     * @param player the player the bot is (either 1 or 2).
     * @return Coordinates of the bots next move.
     */
    @Override
    public Coordinates next(GameState prev, int player)
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

    /**
     * returns the game of the bot.
     * @return "Default Bot" A String of the name of the bot.
     */
    @Override
    public String getName() {
        return "DefaultBot";
    }
}