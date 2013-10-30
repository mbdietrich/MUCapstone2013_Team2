/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player.bot;

import java.util.HashSet;
import java.util.Set;
import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.Opcodes;

/**
 *
 * @author Max
 */
public class DependencyCollector extends ClassVisitor {

    private Set<String> referenced = new HashSet<String>();

    private class MethodCollector extends MethodVisitor{
        public MethodCollector(){
            super(Opcodes.ASM4);
        }
        
        @Override
        public void visitMethodInsn(int opcode, String owner, String name, String desc){
            referenced.add(owner.replace('/', '.'));
        }
    };
    
    public Set<String> getReferenced() {
        return referenced;
    }

    public DependencyCollector() {
        super(Opcodes.ASM4);
    }

    @Override
    public void visit(final int version, final int access, final String name, final String signature, final String superName, final String[] interfaces) {
        if (superName != null) {
            referenced.add(name.replace('/', '.'));
        }
        super.visit(version, access, name, signature, superName, interfaces);
    }

    @Override
    public MethodVisitor visitMethod(int access, String name, String desc, String signature, String[] exceptions) {
        return new MethodCollector();
    }
}
