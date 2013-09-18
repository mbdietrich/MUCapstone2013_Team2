/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

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
        HttpPost postlogin = new HttpPost(URL+"login");
        List<NameValuePair> loginpairs = new ArrayList<NameValuePair>(2);
        loginpairs.add(new BasicNameValuePair("userName", userName));
        loginpairs.add(new BasicNameValuePair("password", password));
        postlogin.setEntity(new UrlEncodedFormEntity(loginpairs));
        HttpResponse loginresp = client.execute(postlogin);       
        postlogin.releaseConnection();
        
        
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
    public void testLeave() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        
        //Log in
        HttpPost postlogin = new HttpPost(URL+"login");
        List<NameValuePair> loginpairs = new ArrayList<NameValuePair>(2);
        loginpairs.add(new BasicNameValuePair("userName", userName));
        loginpairs.add(new BasicNameValuePair("password", password));
        postlogin.setEntity(new UrlEncodedFormEntity(loginpairs));
        HttpResponse loginresp = client.execute(postlogin);       
        postlogin.releaseConnection();
        //Create a game       
        HttpPost postcreate = new HttpPost(URL+"create");
        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
        nameValuePairs.add(new BasicNameValuePair("type", "any")); 
        postcreate.setEntity(new UrlEncodedFormEntity(nameValuePairs));  
        HttpResponse createresp = client.execute(postcreate);
        postcreate.releaseConnection();
        
        // Leave the game
        HttpPost postleave = new HttpPost(URL+"leave");
        HttpResponse leaveresp = client.execute(postleave);
        
        assertEquals(leaveresp.getStatusLine().getStatusCode(), 200);
}
    
    @Test
    public void testGetList() throws ClientProtocolException, IOException{
        HttpClient client = new DefaultHttpClient();
        
        //Log in
        HttpPost postlogin = new HttpPost(URL+"login");
        List<NameValuePair> loginpairs = new ArrayList<NameValuePair>(2);
        loginpairs.add(new BasicNameValuePair("userName", userName));
        loginpairs.add(new BasicNameValuePair("password", password));
        postlogin.setEntity(new UrlEncodedFormEntity(loginpairs));
        HttpResponse loginresp = client.execute(postlogin);       
        postlogin.releaseConnection();
        
        //Get a list of available games
        HttpGet getjoin = new HttpGet(URL+"join");
        HttpResponse joinresp = client.execute(getjoin);
        
        //Print the list
        String responsebody = EntityUtils.toString(joinresp.getEntity());
        System.out.print(responsebody);
        
        assertEquals(joinresp.getStatusLine().getStatusCode(), 200);
}
    
    
    // testState is needed for this
//     @Test
//    public void testMove() throws ClientProtocolException, IOException{
//        HttpClient client = new DefaultHttpClient();
//        
//        //Log in
//        HttpPost postlogin = new HttpPost(URL+"login");
//        List<NameValuePair> loginpairs = new ArrayList<NameValuePair>(2);
//        loginpairs.add(new BasicNameValuePair("userName", userName));
//        loginpairs.add(new BasicNameValuePair("password", password));
//        postlogin.setEntity(new UrlEncodedFormEntity(loginpairs));
//        HttpResponse loginresp = client.execute(postlogin);       
//        postlogin.releaseConnection();
//        //Create a game       
//        HttpPost postcreate = new HttpPost(URL+"create");
//        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
//        nameValuePairs.add(new BasicNameValuePair("type", "any")); 
//        postcreate.setEntity(new UrlEncodedFormEntity(nameValuePairs));  
//        HttpResponse postresp = client.execute(postcreate);
//        postcreate.releaseConnection();
//        
//        //Make a Move
//        HttpPost postmove = new HttpPost(URL+"move");
//        
//        List<NameValuePair> movepairs = new ArrayList<NameValuePair>(2);
//        loginpairs.add(new BasicNameValuePair("a", "1"));
//        loginpairs.add(new BasicNameValuePair("b", "1"));
//        loginpairs.add(new BasicNameValuePair("x", "1"));
//        loginpairs.add(new BasicNameValuePair("y", "1")); 
//        
//        postlogin.setEntity(new UrlEncodedFormEntity(nameValuePairs));  
//        
//        HttpResponse moveresp = client.execute(postmove);
//        
//        assertEquals(moveresp.getStatusLine().getStatusCode(), 200);
//    }
}