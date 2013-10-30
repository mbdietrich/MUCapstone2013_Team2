/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import nz.ac.massey.cs.capstone.player.Bot;
import nz.ac.massey.cs.capstone.game.Coordinates;
import nz.ac.massey.cs.capstone.game.GameState;

/**
 *
 * @author Max
 * Moves outside a valid position
 */
public class InvalidMover extends Bot {

    @Override
    public Coordinates next(GameState prev, int player) {
        return new Coordinates(-1, -1, -1, -1);
    }

    @Override
    public String getName() {
        return "Invalid Mover";
    }
    
}
