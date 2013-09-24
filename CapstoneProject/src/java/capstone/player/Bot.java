/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.Coordinates;
import capstone.game.GameSession;
import capstone.game.GameState;

/**
 *
 * @author Max
 * The default model for a bot.
 */
public abstract class Bot implements Player {

    @Override
    public void notify(GameSession current) {
        current.move(this, next(current.getCurrentGame(), current.getPlayerNumber(this)));
    }
    
    public abstract Coordinates next(GameState prev, int player);
    
    @Override
    public boolean equals(Object o){
        if(o!=null){
            if(o instanceof Bot){
                Bot b = (Bot)o;
                return b.getName().equals(this.getName());
            }
        }
        return false;
    }
}
