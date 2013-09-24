/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import org.junit.After;
import org.junit.Test;

/**
 *
 * @author Max
 */
public class TestExcecutor {
    
    private static List<Method> tests;
    
    private static Method setup;
    
    private static Method teardown;
    
    private static void initialize(){
        tests=new ArrayList<Method>();
        for(Method m:GameBotTest.class.getMethods()){
            if(m.getAnnotation(Test.class)!=null){
                tests.add(m);
            }
            if(m.getAnnotation(After.class)!=null){
                teardown = m;
            }
            if(m.getName().equals("setup")){
                setup = m;
            }
        }
    }
    
    public static boolean testBot(Bot bot) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException{
        
        if(tests==null){
            initialize();
        }
        
        GameBotTest test = new GameBotTest();
        
        setup.invoke(test, bot);
        
        for(Method m: tests){
            //TODO run tests safely
        }
        
        teardown.invoke(test);
        
        return true;
    }
    
}
