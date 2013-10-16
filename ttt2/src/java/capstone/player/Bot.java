/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import capstone.game.Coordinates;
import capstone.game.GameSession;
import capstone.game.GameState;
import capstone.server.util.GameManager;
import capstone.server.util.GameRecorder;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.FutureTask;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/**
 *
 * @author Max The default model for a bot.
 */
public abstract class Bot implements Player {

    public static final ExecutorService executor = new ThreadPoolExecutor(1, 4, 1, TimeUnit.MINUTES, new ArrayBlockingQueue<Runnable>(10));
    
    static class Call implements Callable<Coordinates>{
        
        GameSession session;
        Bot me;
        
        public Call(GameSession current, Bot me){
            session=current;
            this.me=me;
        }
        
        @Override
        public Coordinates call() throws Exception {
                Coordinates newCoord = me.next(session.getCurrentGame(), session.getPlayerNumber(me));
                GameRecorder.record(GameManager.getAnyGameID(session), "Bot", newCoord.getAllCoords());
                return newCoord;
        }
    };

    @Override
    public void notify(GameSession current) {

        Call move = new Call(current, this);

        FutureTask<Coordinates> future = new FutureTask<Coordinates>(move);
                executor.execute(future);
                
            Coordinates c = null;
            try{
                c = future.get(1, TimeUnit.MINUTES);
                current.move(this,c);
                
            } catch (InterruptedException ex) {
                future.cancel(true);
                current.Leave(this);
            } catch (ExecutionException ex) {
                ex.printStackTrace();
            future.cancel(true);
                current.Leave(this);
        } catch (TimeoutException ex) {
            future.cancel(true);
                current.Leave(this);
        }
    }

    public abstract Coordinates next(GameState prev, int player);

    @Override
    public boolean equals(Object o) {
        if (o != null) {
            if (o instanceof Bot) {
                Bot b = (Bot) o;
                return b.getName().equals(this.getName());
            }
        }
        return false;
    }
}
