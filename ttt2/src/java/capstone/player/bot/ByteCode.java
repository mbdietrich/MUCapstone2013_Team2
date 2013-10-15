/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.player.bot;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import javax.tools.JavaFileObject;
import javax.tools.SimpleJavaFileObject;

/**
 *
 * @author Max
 */
public class ByteCode extends SimpleJavaFileObject {

        public ByteCode(String className) {
            super(URI.create("byte:///" + className + ".class"), JavaFileObject.Kind.CLASS);
        }

        @Override
        public CharSequence getCharContent(boolean ignoreEncodingErrors) {
            return null;
        }

        @Override
        public OutputStream openOutputStream() {
            byteArrayOutputStream_ = new ByteArrayOutputStream();
            return byteArrayOutputStream_;
        }

        @Override
        public InputStream openInputStream() {
            return null;
        }

        public byte[] getByteCode() {
            return byteArrayOutputStream_.toByteArray();
        }

        private ByteArrayOutputStream byteArrayOutputStream_;
    }
