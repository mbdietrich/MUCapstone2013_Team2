/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player;

import nz.ac.massey.cs.capstone.game.GameSession;

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
