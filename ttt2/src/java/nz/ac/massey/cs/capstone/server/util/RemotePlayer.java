/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server.util;

import nz.ac.massey.cs.capstone.game.GameSession;
import nz.ac.massey.cs.capstone.player.Player;

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
    
    public boolean equals(Object o){
        if(o!=null){
            if(o instanceof RemotePlayer){
                RemotePlayer b = (RemotePlayer)o;
                return b.getName().equals(this.getName());
            }
        }
        return false;
    }
    
    public String toString(){
    return name;
}
            
    
}
