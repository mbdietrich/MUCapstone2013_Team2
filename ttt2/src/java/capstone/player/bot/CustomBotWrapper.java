/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import capstone.game.Coordinates;
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

    public CustomBotWrapper(Class clazz) throws InstantiationException, IllegalAccessException, NoSuchMethodException {
        Class[] inputTypes = {int[][][][].class, int.class};
        impl = clazz.getMethod("nextMove", inputTypes);
        name = clazz.getMethod("getName", new Class[0]);
        bot = clazz.newInstance();
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
}
