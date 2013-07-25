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
 */
public interface Player {
    
    //Given a game state and which player we are, return the next game state.
    public Coordinates next(GameState prev, int player);
    
}
