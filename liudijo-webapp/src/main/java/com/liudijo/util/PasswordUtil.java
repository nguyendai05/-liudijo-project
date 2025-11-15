package com.liudijo.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    public static byte[] hash(String raw) {
        String salt = BCrypt.gensalt(12);
        String hashed = BCrypt.hashpw(raw, salt);
        return hashed.getBytes(java.nio.charset.StandardCharsets.UTF_8);
    }
    public static boolean verify(String raw, byte[] hashed) {
        if (hashed == null) return false;
        String hs = new String(hashed, java.nio.charset.StandardCharsets.UTF_8);
        return BCrypt.checkpw(raw, hs);
    }
}
