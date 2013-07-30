/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import capstone.game.Coordinates;
import capstone.game.GameSession;
import capstone.game.GameState;
import capstone.player.Player;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Max
 * RemotePlayer represents a connection to a human player.
 * next will query the client for the player's next move.
 */
public class RemotePlayer implements Player {
    
    private String name;
    
    //Is it our turn?
    private boolean active;

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
    
    public RemotePlayer(String name) {
        this.name=name;
    }


    @Override
    public String getName() {
        return name;
    }

    @Override
    public void notify(GameSession current) {
        this.setActive(true);
    }

    
}
