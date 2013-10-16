/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server.jmx;

import capstone.server.util.GameManager;
import java.util.ArrayList;

/**
 *
 * @author Max
 */
public class ServerInspector implements ServerInspectorMBean{

    @Override
    public String getPlayers() {
        return new ArrayList(GameManager.players.values()).toString();
    }

    @Override
    public String getGames() {
        return new ArrayList(GameManager.gameIDs.values()).toString();
    }

    @Override
    public String getOpenGames() {
        return new ArrayList(GameManager.openGames.values()).toString();
    }
    
}
