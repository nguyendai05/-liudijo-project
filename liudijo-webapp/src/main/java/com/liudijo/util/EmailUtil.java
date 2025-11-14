package com.liudijo.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "your-email@gmail.com";
    private static final String SMTP_PASSWORD = "your-app-password";
    private static final String FROM_EMAIL = "noreply@liudijo.com";

    /**
     * Send email using Gmail SMTP
     * @param toEmail recipient email address
     * @param subject email subject
     * @param body email body (HTML supported)
     * @return true if email sent successfully
     */
    public static boolean sendEmail(String toEmail, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Send order confirmation email
     */
    public static boolean sendOrderConfirmation(String toEmail, String orderNumber, String productName) {
        String subject = "Xác nhận đơn hàng #" + orderNumber;
        String body = "<html><body>" +
                "<h2>Cảm ơn bạn đã đặt hàng!</h2>" +
                "<p>Đơn hàng của bạn đã được tiếp nhận.</p>" +
                "<p><strong>Mã đơn hàng:</strong> " + orderNumber + "</p>" +
                "<p><strong>Sản phẩm:</strong> " + productName + "</p>" +
                "<p>Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>" +
                "</body></html>";
        return sendEmail(toEmail, subject, body);
    }

    /**
     * Send welcome email to new user
     */
    public static boolean sendWelcomeEmail(String toEmail, String username) {
        String subject = "Chào mừng đến với Liudijo!";
        String body = "<html><body>" +
                "<h2>Xin chào " + username + "!</h2>" +
                "<p>Cảm ơn bạn đã đăng ký tài khoản tại Liudijo.</p>" +
                "<p>Chúc bạn có những trải nghiệm tuyệt vời!</p>" +
                "</body></html>";
        return sendEmail(toEmail, subject, body);
    }

    /**
     * Send password reset email
     */
    public static boolean sendPasswordResetEmail(String toEmail, String resetLink) {
        String subject = "Đặt lại mật khẩu";
        String body = "<html><body>" +
                "<h2>Yêu cầu đặt lại mật khẩu</h2>" +
                "<p>Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng click vào link dưới đây:</p>" +
                "<p><a href='" + resetLink + "'>Đặt lại mật khẩu</a></p>" +
                "<p>Link này sẽ hết hạn sau 24 giờ.</p>" +
                "<p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>" +
                "</body></html>";
        return sendEmail(toEmail, subject, body);
    }
}
