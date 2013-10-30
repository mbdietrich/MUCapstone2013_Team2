/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author Steve
 */
public class GameRecord {
    private List<String> coords = new ArrayList();
    private String player1 = "";
    private String player2 = "";
    private String gameID = "";

    public List gameList(){
        return coords;
    }
    public List<String> getCoords(){
        return coords;
    }
    public String getGameID(){
        return this.gameID;
    }
    public void setGameID(String gID){
        this.gameID = gID;
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
