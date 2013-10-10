/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import capstone.player.Bot;
import java.net.URI;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.tools.*;
import javax.tools.JavaCompiler.CompilationTask;

/**
 *
 * @author Max
 */
public class BotCompiler {

    static JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();

    
    public static Bot Compile(String source, String id) throws BotCompilationException {
        if (compiler
                == null) {
            throw new BotCompilationException("No compiler found");
        } else {
            DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<JavaFileObject>();
            JavaFileObject file = new JavaSourceFromString(id, source);
            
            Iterable<? extends JavaFileObject> compilationUnits = Arrays.asList(file);
            CompilationTask task = compiler.getTask(null, null, diagnostics, null, null, compilationUnits);
            
            boolean success = task.call();
            
            if(!success){
                throw new BotCompilationException("There was an error compiling the code");
            }
            try {            
                Bot bot = (Bot)Class.forName(id).newInstance();
                
                //TODO validation
                String msg = TestExcecutor.testBot(bot);
                if(msg.equals("Pass")){
                return bot;
                }
                else{
                    throw new BotCompilationException(msg);
                }
                
                
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(BotCompiler.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            } catch (InstantiationException ex) {
                Logger.getLogger(BotCompiler.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            } catch (IllegalAccessException ex) {
                Logger.getLogger(BotCompiler.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            }
        }
    }
    
  static class JavaSourceFromString extends SimpleJavaFileObject {
  final String code;

  JavaSourceFromString(String name, String code) {
    super(URI.create("string:///" + name.replace('.','/') + Kind.SOURCE.extension),Kind.SOURCE);
    this.code = code;
  }

  @Override
  public CharSequence getCharContent(boolean ignoreEncodingErrors) {
    return code;
  }
}
}
