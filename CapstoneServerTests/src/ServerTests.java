/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
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
    
}