/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player.bot;

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
            if(messages.size()>0){
                Diagnostic d = messages.get(0);
                writer.write("Line: "+(d.getLineNumber()-3)+"; "+d.getMessage(Locale.US));
            }
            return writer.toString();
        }
    }