/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.tools.Diagnostic;
import javax.tools.DiagnosticListener;
import javax.tools.JavaFileObject;

public class MyDiagnosticListener implements DiagnosticListener<JavaFileObject>
    {
    
        public List<Diagnostic<? extends JavaFileObject>> messages = new ArrayList<Diagnostic<? extends JavaFileObject>>();
    
        public void report(Diagnostic<? extends JavaFileObject> diagnostic)
        {
            messages.add(diagnostic);
        }
        
        public String toString(){
            StringWriter writer = new StringWriter();
            for(Diagnostic d: messages){
                writer.write("Line: "+(d.getLineNumber()-2)+"; "+d.getMessage(Locale.US)+"<br>");
            }
            return writer.toString();
        }
    }