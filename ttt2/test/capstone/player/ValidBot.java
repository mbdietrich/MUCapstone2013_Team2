/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.Coordinates;
import capstone.game.GameState;
import capstone.server.util.GameManager;

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
