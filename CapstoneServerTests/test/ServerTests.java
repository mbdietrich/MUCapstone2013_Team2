/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import flexjson.JSONDeserializer;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.*;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Max
 */
public class ServerTests {
    
    private static final String URL = "http://capstoneg2.jelastic.servint.net/CapstoneProject/";
    private static final String userName = "ApacheTest";
    private static final String password = "testPass";
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }
    
    @Test
    public void testConnect() throws UnsupportedEncodingException, IOException{
        HttpClient client = new DefaultHttpClient();
        URI uri = URI.create(URL+"index.jsp");
        System.out.println(uri);
        HttpGet get = new HttpGet(uri);
        
        HttpResponse resp = client.execute(get);

        assertEquals(resp.getStatusLine().getStatusCode(), 200);
        
    }
    
    @Test
    public void testLogin() throws UnsupportedEncodingException, IOException{
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(URL+"login");
        
        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
        nameValuePairs.add(new BasicNameValuePair("userName", userName));
        nameValuePairs.add(new BasicNameValuePair("password", password));
        
        post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
        
        HttpResponse resp = client.execute(post);
        
        assertEquals(resp.getStatusLine().getStatusCode(), 200);
    }
  
    @Test
    public void testCreate() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        
        //Log in
        login(client);
        
        //Create a game       
        HttpPost post = new HttpPost(URL+"create");
 
        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
        nameValuePairs.add(new BasicNameValuePair("type", "any")); 

        post.setEntity(new UrlEncodedFormEntity(nameValuePairs));  
     
        HttpResponse resp = client.execute(post);
        
        // If it was successful, the response is either "joined" or "created"
        // #TODO: (better way to write the assert???)
        String responsebody = EntityUtils.toString(resp.getEntity());
        boolean flag = false;
        if (responsebody.equals("created")| responsebody.equals("joined")){
            flag = true;
        }
        
        assertTrue(flag);
    }
    
     @Test
    public void testState() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        login(client);              //Log in
        createGame(client,"solo");  //Create solo game
        
        HttpGet getstate = new HttpGet(URL+"state");
        HttpResponse stateresp = client.execute(getstate);
        
        String responsebody = EntityUtils.toString(stateresp.getEntity());
        
        //Find the JSON section of the response
        int startJSON = responsebody.indexOf("{");
        int stopJSON = responsebody.indexOf("}"); 
        String JSONstate = responsebody.substring(startJSON, stopJSON+1);
        
        HashMap state = (HashMap) new JSONDeserializer().deserialize(JSONstate);

        //TODO: Better pass condition?
        assertEquals(stateresp.getStatusLine().getStatusCode(), 200);
    }
	
	@Test
    public void testLeave() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        login(client);              // Log in     
        createGame(client, "any");         //Create a game    
        
        // Leave the game
        HttpPost postleave = new HttpPost(URL+"leave");
        HttpResponse leaveresp = client.execute(postleave);
        
        assertEquals(leaveresp.getStatusLine().getStatusCode(), 200);
}
    
    @Test
    public void testGetList() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        login(client);              // Log in  
        createGame(client, "solo");
        
        //Get a list of available games
        HttpGet getjoin = new HttpGet(URL+"join");
        HttpResponse joinresp = client.execute(getjoin);
        
        //Print the list
        String responsebody = EntityUtils.toString(joinresp.getEntity());
        //String[][] games = new JSONDeserializer<String[][]>().deserialize(responsebody);
        System.out.print(responsebody);
        
        assertTrue(responsebody.contains("ApacheTest"));
}
    
     @Test
    public void testMove() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        login(client);              // Log in     
        createGame(client, "solo");         //Create a game   
        
        //Make a Move
        HttpPost postmove = new HttpPost(URL+"move");
        
        List<NameValuePair> movepairs = new ArrayList<NameValuePair>(4);
        movepairs.add(new BasicNameValuePair("a", "1"));
        movepairs.add(new BasicNameValuePair("b", "1"));
        movepairs.add(new BasicNameValuePair("x", "1"));
        movepairs.add(new BasicNameValuePair("y", "1")); 
        
        postmove.setEntity(new UrlEncodedFormEntity(movepairs));  
        
        HttpResponse moveresp = client.execute(postmove);
        
        assertEquals(moveresp.getStatusLine().getStatusCode(), 200);
    }

    public void login(HttpClient client) throws UnsupportedEncodingException, IOException{
        HttpPost postlogin = new HttpPost(URL+"login");
        List<NameValuePair> loginpairs = new ArrayList<NameValuePair>(2);
        loginpairs.add(new BasicNameValuePair("userName", userName));
        loginpairs.add(new BasicNameValuePair("password", password));
        postlogin.setEntity(new UrlEncodedFormEntity(loginpairs));
        HttpResponse loginresp = client.execute(postlogin);       
        postlogin.releaseConnection();
    }

    public void createGame(HttpClient client, String type) throws UnsupportedEncodingException, IOException{
        HttpPost postcreate = new HttpPost(URL+"create");
        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
        nameValuePairs.add(new BasicNameValuePair("type", type));  
        postcreate.setEntity(new UrlEncodedFormEntity(nameValuePairs));  
        HttpResponse postresp = client.execute(postcreate);
        postcreate.releaseConnection();        
    }
}