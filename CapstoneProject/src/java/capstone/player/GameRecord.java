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
    public String player1 = "";
    public String player2 = "";

    public List gameList(){
        return coords;
    }
    public void putCoords(String coord){
        coords.add(coord);
    }
    public void setPlayer1(String player1){
        this.player1 = player1;
    }
    public void setPlayer2(String player2){
        this.player2 = player2;
    }
    public String getPlayer1(){
        return this.player1;
    }
    public String getPlayer2(){
        return this.player2;
    }
}
