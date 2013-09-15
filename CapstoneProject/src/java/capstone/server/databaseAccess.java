/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author luke
 */
public class databaseAccess {
    private static Statement createConnection() throws Exception {
	Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://mysql-CapstoneG2.jelastic.servint.net/tictactoedb?useUnicode=yes&characterEncoding=UTF-8", "admin", "capstone2");
        return con.createStatement();
    }
	
    public static String checkLoginCredentials(String userName, String password) {
	try {
            Statement st = createConnection();
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+Encryption.encrypt(userName)+"'");
            if(rs.next()) {
                if(Encryption.decrypt(rs.getString(2)).equals(password)) {
                    return userName;
		} else {
                    st.close();
                    return "loginError";
		}
            } else {
		st.close();
		return "loginError";
            }
	}
	catch (Exception e) {
            e.printStackTrace();
            return "exception";
	}
    }
    
    public static Map getPlayerDetails(String player) {
        Map details = new HashMap();
        try {
            Statement st = createConnection();
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE user ='"+Encryption.encrypt(player)+"'");
            if(rs.next()) {
                details.put("userName", Encryption.decrypt(rs.getString(1)));
                details.put("password", Encryption.decrypt(rs.getString(2)));
                details.put("email", Encryption.decrypt(rs.getString(3)));
                details.put("fbid", Encryption.decrypt(rs.getString(4)));
            }
            st.close();
            return details;
	}
	catch (Exception e) {
            e.printStackTrace();
            return details;
	}
    }
    
    public static boolean addPlayer(Map details) {
        try {
            Statement st = createConnection();
            st.executeUpdate("INSERT into players (user, password, email, fbid) VALUES ('"+Encryption.encrypt(details.get("userName").toString())+"','"+Encryption.encrypt(details.get("password").toString())+"','"+Encryption.encrypt(details.get("email").toString())+"','"+Encryption.encrypt(details.get("fbid").toString())+"')");
            st.close();
            return true;
	}
	catch (Exception e) {
            e.printStackTrace();
            return false;
	}
    }
    
    public static boolean updatePlayerDetails(Map details) {
        try {
            Statement st = createConnection();
            st.executeUpdate("UPDATE players SET user='"+Encryption.encrypt(details.get("userName").toString())+"', email='"+Encryption.encrypt(details.get("email").toString())+"', password='"+Encryption.encrypt(details.get("password").toString())+"' WHERE user='"+Encryption.encrypt(details.get("oldUserName").toString())+"'");
            return true;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean playerExists(String player) {
        Map details = getPlayerDetails(player);
        if(details.isEmpty()) {
            return false;
        } else {
            return true;
        }
    }
    
    public static boolean emailExists(String email) {
        try {
            Statement st = createConnection();
            ResultSet rs = st.executeQuery("SELECT * FROM players WHERE email ='"+Encryption.encrypt(email)+"'");
            if(rs.next()) {
                st.close();
                return true;   
            } else {
                st.close();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }
}
