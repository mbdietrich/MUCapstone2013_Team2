/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server.util;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author luke
 */
public class Encryption {
    
    public static String encrypt(String value) throws Exception {
        SecretKeySpec sks = new SecretKeySpec(hexStringToByteArray("73cc4ee5b7d64a74a6ed7388703f1693"), "AES");
	Cipher cipher = Cipher.getInstance("AES");
	cipher.init(Cipher.ENCRYPT_MODE, sks, cipher.getParameters());
	byte[] encrypted = cipher.doFinal(value.getBytes());
	return byteArrayToHexString(encrypted);
    }
	
    public static String decrypt(String message) throws Exception {
        SecretKeySpec sks = new SecretKeySpec(hexStringToByteArray("73cc4ee5b7d64a74a6ed7388703f1693"), "AES");
	Cipher cipher = Cipher.getInstance("AES");
	cipher.init(Cipher.DECRYPT_MODE, sks);
	byte[] decrypted = cipher.doFinal(hexStringToByteArray(message));
	return new String(decrypted);
    }
	
    private static String byteArrayToHexString(byte[] b){
        StringBuffer sb = new StringBuffer(b.length * 2);
	for (int i = 0; i < b.length; i++){
            int v = b[i] & 0xff;
            if (v < 16) {
		sb.append('0');
            }
            sb.append(Integer.toHexString(v));
	}
	return sb.toString().toUpperCase();
    }
	
    private static byte[] hexStringToByteArray(String s) {
	byte[] b = new byte[s.length() / 2];
	for (int i = 0; i < b.length; i++){
            int index = i * 2;
            int v = Integer.parseInt(s.substring(index, index + 2), 16);
            b[i] = (byte)v;
	}
	return b;
    }
}
