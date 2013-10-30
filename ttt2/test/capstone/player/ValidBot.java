/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import nz.ac.massey.cs.capstone.player.Bot;
import nz.ac.massey.cs.capstone.game.Coordinates;
import nz.ac.massey.cs.capstone.game.GameState;
import nz.ac.massey.cs.capstone.server.util.GameManager;

/**
 *
 * @author Max
 */
public class ValidBot extends Bot{

    @Override
    public Coordinates next(GameState prev, int player) {
        return GameManager.DEFAULT_BOT.next(prev, player);
    }

    @Override
    public String getName() {
        return "ValidBot";
    }
    
}
