/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

/**
 *
 * @author Max
 * 
 * Thrown when a game is illegal, i.e. the game rules
 * are violated or more/less than two players are
 * assigned to a game.
 */
public class IllegalGameException extends Exception{

    public IllegalGameException() {
    }

    public IllegalGameException(String message) {
        super(message);
    }
    
}
