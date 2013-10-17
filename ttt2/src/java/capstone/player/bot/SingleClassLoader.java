/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import java.net.URL;
import java.net.URLClassLoader;

/**
 *
 * @author Max
 */
public class SingleClassLoader extends URLClassLoader {

        public SingleClassLoader(ByteCode byteCode, URL[] urls) {
            super(urls);
            bcode = byteCode;
        }
        
        
        @Override
        protected Class findClass(String className) throws ClassNotFoundException {
            try{
                return super.findClass(className);
            }
            catch(ClassNotFoundException ce){
                return defineClass(className, bcode.getByteCode(), 0, bcode.getByteCode().length);
            }
            
        }

        ByteCode getFileObject() {
            return bcode;
        }

        private final ByteCode bcode;
    }
