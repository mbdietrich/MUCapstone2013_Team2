/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player;

import com.sun.org.apache.xalan.internal.xsltc.compiler.CompilerException;
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

    public static Bot Compile(String source, String id) throws CompilerException {
        if (compiler
                == null) {
            throw new CompilerException("No compiler found");
        } else {
            DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<JavaFileObject>();
            JavaFileObject file = new JavaSourceFromString(id, source);
            
            Iterable<? extends JavaFileObject> compilationUnits = Arrays.asList(file);
            CompilationTask task = compiler.getTask(null, null, diagnostics, null, null, compilationUnits);
            
            boolean success = task.call();
            
            if(!success){
                throw new CompilerException("There was an error compiling the code");
            }
            try {            
                Bot bot = (Bot)Class.forName(id).newInstance();
                
                //TODO
                return null;
                
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
