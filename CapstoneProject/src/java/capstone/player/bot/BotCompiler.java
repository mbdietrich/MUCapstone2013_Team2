/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import capstone.player.Bot;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Arrays;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.tools.*;
import javax.tools.JavaCompiler.CompilationTask;
import org.objectweb.asm.ClassReader;

/**
 *
 * @author Max
 */
public class BotCompiler {

    private static JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();

    public static Bot createBot(String methodBody, String id, String path) throws BotCompilationException {
        StringWriter writer = new StringWriter();
        PrintWriter out = new PrintWriter(writer);
        out.println("public class " + id + " extends Bot {");
        out.println("  public Coordinates next(GameState prev, int player) {");
        out.println(methodBody);
        out.println("  }");
        out.println("  public String getName(){");
        out.println("     return \"" + id + "\"");
        out.println("  }");
        out.println("}");
        out.close();

        JavaFileObject so = null;
        try {
            so = new InMemoryJavaFileObject(id, writer.toString());
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        return compile(so, id, path);
    }

    private static Bot compile(JavaFileObject source, String id, String path) throws BotCompilationException {
        if (compiler
                == null) {
            throw new BotCompilationException("No compiler found");
        } else {

            MyDiagnosticListener c = new MyDiagnosticListener();
            StandardJavaFileManager fileManager = compiler.getStandardFileManager(c,
                    Locale.ENGLISH,
                    null);
            Iterable options = Arrays.asList("-d", path);
            JavaCompiler.CompilationTask task = compiler.getTask(null, fileManager,
                    c, options, null,
                    Arrays.asList(source));

            boolean result = task.call();
            if (!result) {
                throw new BotCompilationException("There was a problem compiling the code");
            }
            //TODO load bot

            try {
                File file = new File(path);
                URL url = file.toURL();
                URL[] urls = new URL[]{url};

                
                ClassLoader loader = new URLClassLoader(urls);

                Class thisClass = loader.loadClass(id);
                
                securityCheck(thisClass, path);

                Bot bot = (Bot)thisClass.newInstance();
                
            String msg = TestExcecutor.testBot(bot);
                if (msg.equals("Pass")) {
                    return bot;
                } else {
                    throw new BotCompilationException(msg);
                }
                
            } catch (MalformedURLException ex) {
                throw new BotCompilationException("There was an error loading the bytecode");
            } catch (ClassNotFoundException ex) {
                throw new BotCompilationException("There was an error loading the bytecode");
            } catch (InstantiationException ex) {
                throw new BotCompilationException("There was an error loading the bytecode");
            } catch (IllegalAccessException ex) {
                throw new BotCompilationException("There was an error loading the bytecode");
            } catch (SecurityException ex) {
                throw new BotCompilationException("There was an error loading the bytecode");
            }

        }
    }
    
    private static void securityCheck(Class clazz, String path) throws BotCompilationException{
        InputStream in = null;
        try {
            DependencyCollector  collector = new DependencyCollector();
            File classFile = new File(path + clazz.getName().replace('.','/')+".class");
            in = new FileInputStream(classFile);
            new ClassReader(in).accept(collector, 0);
            
            for (String ref:collector.getReferenced()) {
                if(ref.startsWith("java.util")||ref.startsWith("capstone")){
                    continue;
                }
                if(ref.startsWith("java.lang")&&!ref.contains("System")){
                    continue;
                }
                throw new BotCompilationException("Error: Access to classes outside of bot-specific classes, java.util and java.lang (except System) not permitted.");
            }
            
        } catch (FileNotFoundException ex) {
            throw new BotCompilationException("There was an error accessing the bytecode");
        } catch (IOException ex) {
            throw new BotCompilationException("There was an error accessing the bytecode");
        } finally {
            try {
                in.close();
            } catch (IOException ex) {
                throw new BotCompilationException("There was an error accessing the bytecode");
            }
        }

    }
}
