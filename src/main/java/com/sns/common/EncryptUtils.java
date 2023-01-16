package com.sns.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptUtils {
	public static String md5(String message) { // static: 우선 메모리에 올라가있는 상태로 시작
		String encData = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
		
			byte[] bytes = message.getBytes();
	        md.update(bytes);
	        byte[] digest = md.digest();
	        
	        for(int i = 0; i < digest.length; i++ ) {
	            encData += Integer.toHexString(digest[i]&0xff); // 16진수로 변환하는 과정
	        }
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return encData;
	}
}
