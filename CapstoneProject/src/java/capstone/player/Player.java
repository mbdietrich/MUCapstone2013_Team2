/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.GameSession;

/**
 *
 * @author Max
 */
public interface Player {
    
    //Given a game state and which player we are, return the next game state.
    public String getName();
    
    //notify the player that they are ready to make the next move
    public void notify(GameSession current);
    
}
