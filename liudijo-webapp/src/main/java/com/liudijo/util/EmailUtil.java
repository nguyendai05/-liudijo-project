package com.liudijo.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/** Minimal email sender (configure env: SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS). */
public class EmailUtil {
    public static void send(String to, String subject, String content) {
        String host = System.getenv().getOrDefault("SMTP_HOST", "localhost");
        int port = Integer.parseInt(System.getenv().getOrDefault("SMTP_PORT", "25"));
        String user = System.getenv().getOrDefault("SMTP_USER", "");
        String pass = System.getenv().getOrDefault("SMTP_PASS", "");

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "" + port);
        if (!user.isEmpty()) {
            props.put("mail.smtp.auth", "true");
        }

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                if (user.isEmpty()) return null;
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user.isEmpty() ? "no-reply@liudijo" : user));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
