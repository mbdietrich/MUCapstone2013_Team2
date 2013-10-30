/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.player.bot;

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
            outStream = new ByteArrayOutputStream();
            return outStream;
        }

        @Override
        public InputStream openInputStream() {
            return null;
        }

        public byte[] getByteCode() {
            return outStream.toByteArray();
        }

        private ByteArrayOutputStream outStream;
    }
