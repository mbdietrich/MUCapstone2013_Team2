/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.Coordinates;
import capstone.game.GameState;

/**
 *
 * @author Max
 * Loops infinitely
 */
class InfiniteLoopBot extends Bot {

    private static boolean FLAG = true;
    
    @Override
    public Coordinates next(GameState prev, int player) {
        while(FLAG){}                
        return null;
    }

    @Override
    public String getName() {
        return "Infinite Loop Bot";
    }
    
}
