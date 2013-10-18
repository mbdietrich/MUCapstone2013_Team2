/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import capstone.game.Coordinates;
import capstone.game.GameRules;
import capstone.game.GameState;
import capstone.player.Bot;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 *
 * @author Max
 */
public class CustomBotWrapper extends Bot {

    //All custom bots should implement the method int[][] nextMove(int[][][][], int)
    private Method impl;
    private Method name;
    private Object bot;

    public CustomBotWrapper(Class clazz) throws InstantiationException, IllegalAccessException, NoSuchMethodException, IllegalArgumentException, InvocationTargetException {
        impl = clazz.getMethod("nextMove", new Class[]{int[][][][].class, int.class});
        name = clazz.getMethod("getName", new Class[0]);
        Method myValidMove = CustomBotWrapper.class.getMethod("validMove", new Class[]{int[][][][].class, int[][].class});
        Method myBoardStatus = CustomBotWrapper.class.getMethod("boardStatus", new Class[]{int[][].class});
        
        bot = clazz.getConstructor(Method.class, Method.class).newInstance(myValidMove, myBoardStatus);
    }

    @Override
    public Coordinates next(GameState prev, int player) {
        //Prepare input - deep copy
        int[][][][] input = new int[3][3][3][3];
        for (int a = 0; a < 3; a++) {
            for (int b = 0; b < 3; b++) {
                for (int x = 0; x < 3; x++) {
                    for (int y = 0; y < 3; y++) {
                        input[a][b][x][y] = prev.GetSubBoard(a, b)[x][y];
                    }
                }
            }
        }
        int[][] output;
        try {
            output = (int[][]) impl.invoke(bot, input, player);
            return new Coordinates(output[0][0], output[0][1], output[1][0], output[1][1]);
        } catch (IllegalAccessException ex) {
            return null;
        } catch (IllegalArgumentException ex) {
            return null;
        } catch (InvocationTargetException ex) {
            return null;
        }
    }

    @Override
    public String getName() {
        try {
            return name.invoke(bot).toString();
        } catch (IllegalAccessException ex) {
            return "";
        } catch (IllegalArgumentException ex) {
            return "";
        } catch (InvocationTargetException ex) {
            return "";
        }
    }
 
    //TODO wrap these
    public static boolean validMove(int[][][][] board, int[][] coord){
        return GameRules.validMove(new GameState(board), new Coordinates(coord[0][0],coord[0][1],coord[1][0],coord[1][1]));
    }
    
    public static int boardStatus(int[][] board){
        return GameRules.checkStatusBoard(board);
    }
}
