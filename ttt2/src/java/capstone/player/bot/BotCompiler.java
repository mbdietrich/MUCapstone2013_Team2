/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import capstone.player.Bot;
import capstone.server.util.GameManager;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.tools.*;
import org.objectweb.asm.ClassReader;

/**
 *
 * @author Max
 */
public class BotCompiler {

    private static JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();

    public static Bot createBot(String methodBody, String id, String path) throws BotCompilationException, IOException {
        StringWriter writer = new StringWriter();
        PrintWriter out = new PrintWriter(writer);
        out.println("import java.util.*;");
        out.println("import capstone.game.*;");
        out.println("import capstone.player.Bot;");
        out.println("public class " + id + " extends Bot {");
        out.println(methodBody);
        out.println("  public String getName(){");
        out.println("     return \"" + id + " (Bot)\";");
        out.println("  }");
        out.println("}");
        out.close();

        JavaFileObject so = null;
        try {
            so = new CompilationUnit(id, writer.toString());
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        Bot bot = compile(so, id, path);
        return bot;
    }
    
    public static Bot load(String id, String path){
        try {
            //TODO load bot
            File file = new File(path);
            URL url = file.toURI().toURL();
            URL[] urls = new URL[]{url};
            ClassLoader loader = new URLClassLoader(urls);
            Class thisClass = loader.loadClass(id);
            return (Bot)thisClass.newInstance();
            
        } catch (Exception ex) {
            return GameManager.DEFAULT_BOT;
        }
    }

    private static Bot compile(JavaFileObject source, String id, String path) throws BotCompilationException, IOException {
        if (compiler
                == null) {
            throw new BotCompilationException("No compiler found");
        } else {

            
            MyDiagnosticListener c = new MyDiagnosticListener();
            SingleFileManager fileManager = new SingleFileManager(compiler, new ByteCode(id));
            JavaCompiler.CompilationTask task = compiler.getTask(null, fileManager,
                    c, null, null,
                    Arrays.asList(source));

            boolean result = task.call();
            if (!result) {
                throw new BotCompilationException("There was a problem compiling the code");
            }

            try {
                Class thisClass = fileManager.getClassLoader().findClass(id);
                byte[] bCode = fileManager.getClassLoader().getFileObject().getByteCode();
                securityCheck(new ByteArrayInputStream(bCode), id);

                Bot bot = (Bot)thisClass.newInstance();
                
            String msg = TestExcecutor.testBot(bot);
                if (msg.equals("Pass")) {
                    //Save bot
                    File bytefile = new File(path+"/"+id+".class");
                    File srcfile = new File(path+"/src/"+id+".src");
                    if(bytefile.exists()){
                        bytefile.delete();
                    }
                    if(srcfile.exists()){
                        srcfile.delete();
                    }
                    bytefile.createNewFile();
                    srcfile.createNewFile();
                    
                    FileOutputStream outbyte = new FileOutputStream(bytefile);
                    outbyte.write(bCode);
                    outbyte.close();
                    
                    PrintWriter outsrc = new PrintWriter(srcfile);
                    outsrc.print(srcfile);
                    outsrc.close();
                    
                    return bot;
                } else {
                    throw new BotCompilationException(msg);
                }
                
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
    
    private static void securityCheck(InputStream is, String id) throws BotCompilationException{
        try {
            DependencyCollector  collector = new DependencyCollector();
            new ClassReader(is).accept(collector, 0);
                for (String ref:collector.getReferenced()) {
                    if(ref.startsWith("java.util")||ref.startsWith("capstone.game")||ref.startsWith("capstone.player")||ref.equals(id)){
                        continue;
                    }
                    if(ref.startsWith("java.lang")&&!ref.contains("System")){
                        continue;
                    }
                    throw new BotCompilationException("Error: Access to classes outside of bot-specific classes, java.util and java.lang (except System) not permitted.");
                }
        } catch (IOException ex) {
            Logger.getLogger(BotCompiler.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
