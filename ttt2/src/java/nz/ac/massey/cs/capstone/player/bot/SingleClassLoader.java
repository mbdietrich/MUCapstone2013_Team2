/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player.bot;

/**
 *
 * @author Max
 */
public class SingleClassLoader extends ClassLoader {

        public SingleClassLoader(ByteCode byteCode) {
            bcode = byteCode;
        }
        
        
        @Override
        protected Class findClass(String className) throws ClassNotFoundException {
            return defineClass(className, bcode.getByteCode(), 0, bcode.getByteCode().length);
            
        }

        ByteCode getFileObject() {
            return bcode;
        }

        private final ByteCode bcode;
    }
