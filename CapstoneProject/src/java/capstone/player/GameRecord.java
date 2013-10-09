/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author Steve
 */
public class GameRecord {
    public List<String> coords = new ArrayList();

    public List gameList(){
        return coords;
    }
    public void putCoords(String coord){
        coords.add(coord);
    }
}
