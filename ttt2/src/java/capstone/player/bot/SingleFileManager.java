/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import java.io.IOException;
import javax.tools.FileObject;
import javax.tools.ForwardingJavaFileManager;
import javax.tools.JavaCompiler;
import javax.tools.JavaFileManager;
import javax.tools.JavaFileObject;

class SingleFileManager extends ForwardingJavaFileManager {

        public SingleFileManager(JavaCompiler compiler, ByteCode byteCode) {
            super(compiler.getStandardFileManager(null, null, null));
            loader = new SingleClassLoader(byteCode);
        }

        @Override
        public JavaFileObject getJavaFileForOutput(JavaFileManager.Location notUsed, String className, JavaFileObject.Kind kind,
            FileObject sibling) throws IOException {
            return loader.getFileObject();
        }

        @Override
        public ClassLoader getClassLoader(JavaFileManager.Location location) {
            return loader;
        }

        public SingleClassLoader getClassLoader() {
            return loader;
        }

        private final SingleClassLoader loader;
    }