/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

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

    public HttpSession getSession() {
        return session;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    @Override
    public GameState next(GameState prev) {
        throw new UnsupportedOperationException("Not supported yet.");
        //TODO add client interaction code
        }
    
}
