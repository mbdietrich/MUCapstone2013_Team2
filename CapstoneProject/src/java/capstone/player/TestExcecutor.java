/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.FutureTask;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
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
        
        final GameBotTest test = new GameBotTest();
        
        setup.invoke(test, bot);
        ExecutorService executor = new ThreadPoolExecutor(1, 4, 2, TimeUnit.MINUTES, new ArrayBlockingQueue<Runnable>(10));
        
        for(final Method m: tests){
            //TODO run tests safely
            Callable call = new Callable<String>(){
                
                @Override
                public String call(){
                    try{
                        m.invoke(test);
                        return "OK";
                    }
                    catch(AssertionError e){
                        return e.getMessage();
                    }
                    catch(Throwable e){
                        return "Test "+m.getName()+" threw "+e.getClass().getSimpleName()+" at line "+e.getStackTrace()[0].getLineNumber();
                    }
                }
            };
            
            FutureTask<String> future = new FutureTask<String>(call);
            executor.execute(future);
            
            String message="";
            //TODO run test and timeout measures
        }
        
        teardown.invoke(test);
        
        return true;
    }
    
}
