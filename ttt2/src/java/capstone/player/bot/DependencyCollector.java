/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import java.util.HashSet;
import java.util.Set;
import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.Opcodes;

/**
 *
 * @author Max
 */
public class DependencyCollector extends ClassVisitor {

    private Set<String> referenced = new HashSet<String>();

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
}
