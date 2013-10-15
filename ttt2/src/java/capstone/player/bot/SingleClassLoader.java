/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

/**
 *
 * @author Max
 */
public class SingleClassLoader extends ClassLoader {

        public SingleClassLoader(ByteCode byteCode) {
            byteCode_ = byteCode;
        }

        @Override
        protected Class findClass(String className) throws ClassNotFoundException {
            return defineClass(className, byteCode_.getByteCode(), 0, byteCode_.getByteCode().length);
        }

        ByteCode getFileObject() {
            return byteCode_;
        }

        private final ByteCode byteCode_;
    }
