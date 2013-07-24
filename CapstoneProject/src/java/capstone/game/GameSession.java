/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.game;

import capstone.player.Player;

/**
 *
 * @author Max
 */
public class GameSession {
    private GameState game=new GameState();
    
    private Player playerA=null, playerB=null;

    public GameState getGame() {
        return game;
    }

    public void setGame(GameState game) {
        this.game = game;
    }

    public Player getPlayerA() {
        return playerA;
    }

    public void setPlayerA(Player playerA) {
        this.playerA = playerA;
    }

    public Player getPlayerB() {
        return playerB;
    }

    public void setPlayerB(Player playerB) {
        this.playerB = playerB;
    }
    
    public boolean isReady(){
        return (playerA!=null)&&(playerB!=null);
    }
    
}
