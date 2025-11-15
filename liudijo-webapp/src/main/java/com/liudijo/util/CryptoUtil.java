package com.liudijo.util;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

/** AES-GCM encryption for stock secrets. Keep key safe! */
public class CryptoUtil {
    // 256-bit key from env (Base64); if absent, generate ephemeral (NOT for prod)
    private static final byte[] KEY;
    static {
        String b64 = System.getenv("AES_KEY_B64");
        if (b64 != null && !b64.isEmpty()) {
            KEY = Base64.getDecoder().decode(b64);
        } else {
            try {
                KeyGenerator kg = KeyGenerator.getInstance("AES");
                kg.init(256);
                KEY = kg.generateKey().getEncoded();
            } catch (Exception e) { throw new RuntimeException(e); }
        }
    }

    public static byte[] encrypt(byte[] plain) {
        try {
            byte[] iv = new byte[12];
            new SecureRandom().nextBytes(iv);
            Cipher c = Cipher.getInstance("AES/GCM/NoPadding");
            SecretKey k = new SecretKeySpec(KEY, "AES");
            c.init(Cipher.ENCRYPT_MODE, k, new GCMParameterSpec(128, iv));
            byte[] ct = c.doFinal(plain);
            byte[] out = new byte[iv.length + ct.length];
            System.arraycopy(iv,0,out,0,iv.length);
            System.arraycopy(ct,0,out,iv.length,ct.length);
            return out;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    public static byte[] decrypt(byte[] enc) {
        try {
            byte[] iv = new byte[12];
            System.arraycopy(enc,0,iv,0,12);
            byte[] ct = new byte[enc.length - 12];
            System.arraycopy(enc,12,ct,0,ct.length);
            Cipher c = Cipher.getInstance("AES/GCM/NoPadding");
            SecretKey k = new SecretKeySpec(KEY, "AES");
            c.init(Cipher.DECRYPT_MODE, k, new GCMParameterSpec(128, iv));
            return c.doFinal(ct);
        } catch (Exception e) { throw new RuntimeException(e); }
    }
}
