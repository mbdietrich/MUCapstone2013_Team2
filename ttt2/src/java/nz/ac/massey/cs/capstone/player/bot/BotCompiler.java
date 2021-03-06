/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player.bot;

import nz.ac.massey.cs.capstone.player.Bot;
import nz.ac.massey.cs.capstone.server.util.GameManager;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
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
    private static final String sep = System.getProperty("file.separator");

    public static Bot createBot(String methodBody, String id, String path) throws BotCompilationException, IOException {
        StringWriter writer = new StringWriter();
        PrintWriter out = new PrintWriter(writer);

        //Declaration
        out.println("import java.util.*;");
        out.println("import java.lang.reflect.*;");
        out.println("public class " + id + " {");
        //Method
        out.println(methodBody);
        //Name
        out.println("  public String getName(){");
        out.println("     return \"" + id + " (Bot)\";");
        out.println("  }");
        //Other
        out.println("private Method m1;");
        out.println("private Method m2;");
        //Constructor
        out.println("public " + id + "(Method m1, Method m2){");
        out.println("   this.m1=m1;");
        out.println("   this.m2=m2;");
        out.println("   }");
        //Methods
        out.println("private boolean validMove(int[][][][] board, int[][] coord){");
        out.println("       try{return (Boolean)m1.invoke(null, board, coord);}");
        out.println("       catch(Exception e){return false;}");
        out.println("   }");

        out.println("private int boardStatus(int[][] board){");
        out.println("try{return (Integer)m2.invoke(null, board);}");
        out.println("catch(Exception e){return -1;}");
        out.println("   }");
        out.println("}");
        out.close();

        JavaFileObject so = null;
        try {
            so = new CompilationUnit(id, writer.toString());
        } catch (Exception exception) {
            //Won't happen
        }

        Bot bot = compile(so, id, path);

        File srcfolder = new File(path + "src" + sep);
        srcfolder.mkdirs();
        File srcfile = new File(path + "src" + sep + id + ".src");

        if (srcfile.exists()) {
            srcfile.delete();
        }

        srcfile.createNewFile();

        PrintWriter outsrc = new PrintWriter(srcfile);

        outsrc.print(methodBody);
        outsrc.close();
        return bot;
    }

    public static Bot load(String id, String path) {
        try {
            //TODO load bot
            path=path+id+".class";
            File file = new File(path);
            URL url = file.toURI().toURL();
            URL[] urls = new URL[]{url};
            ClassLoader loader = new URLClassLoader(urls);
            Class thisClass = loader.loadClass(id);
            return new CustomBotWrapper(thisClass);

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
                throw new BotCompilationException(c.toString());
            }

            try {

                Class thisClass = fileManager.getClassLoader().findClass(id);
                byte[] bCode = fileManager.getClassLoader().getFileObject().getByteCode();
                securityCheck(new ByteArrayInputStream(bCode), id);

                Bot bot = new CustomBotWrapper(thisClass);

                String msg = TestExcecutor.testBot(bot);
                if (msg.equals("Pass")) {
                    //Save bot
                    File folder = new File(path);
                    folder.mkdirs();
                    File bytefile = new File(path + id + ".class");

                    if (bytefile.exists()) {
                        bytefile.delete();
                    }
                    bytefile.createNewFile();

                    FileOutputStream outbyte = new FileOutputStream(bytefile);
                    outbyte.write(bCode);
                    outbyte.close();

                    return bot;
                } else {
                    throw new BotCompilationException(msg);
                }

            } catch (ClassNotFoundException ex) {
                throw new BotCompilationException("There was an error loading the bytecode: Could not find class");
            } catch (InstantiationException ex) {
                throw new BotCompilationException("There was an error loading the bytecode: Could not instantiate bot");
            } catch (IllegalAccessException ex) {
                throw new BotCompilationException("There was an error loading the bytecode: Illegal access modifier");
            } catch (SecurityException ex) {
                throw new BotCompilationException("There was an error loading the bytecode: Security Violation");
            } catch (NoSuchMethodException ex) {
                throw new BotCompilationException("Method must be called nextMove.");
            } catch (IllegalArgumentException ex) {
                throw new BotCompilationException("Error instantiating bot.");
            } catch (InvocationTargetException ex) {
                throw new BotCompilationException("Error instantiating bot.");
            }

        }
    }

    private static void securityCheck(InputStream is, String id) throws BotCompilationException {
        try {
            DependencyCollector collector = new DependencyCollector();
            new ClassReader(is).accept(collector, 0);
            for (String ref : collector.getReferenced()) {
                if (ref.startsWith("java.util") || ref.equals(id)) {
                    continue;
                }
                if (ref.startsWith("java.lang") && !ref.contains("System")) {
                    continue;
                }
                throw new BotCompilationException("Error: Access to classes outside of java.util and java.lang (except System) not permitted.");
            }
        } catch (IOException ex) {
            Logger.getLogger(BotCompiler.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
