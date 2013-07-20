/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.GameState;

/**
 *
 * @author Max
 */
public interface Player {
    
    //Given a game state, return the next game state.
    public GameState next(GameState prev);
    
}
