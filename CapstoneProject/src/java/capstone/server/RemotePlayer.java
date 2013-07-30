/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import capstone.game.Coordinates;
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
    
    private HttpSession session;
    private String name;
    
    public RemotePlayer(HttpSession session, String name) {
        this.session=session;
        this.name=name;
    }

    public HttpSession getSession() {
        return session;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    @Override
    public Coordinates next(GameState prev, int player) {
        //TODO
        Coordinates coords = new Coordinates(0,0,0,0);
        return coords;
    }

    @Override
    public String getName() {
        return name;
    }

    
}
