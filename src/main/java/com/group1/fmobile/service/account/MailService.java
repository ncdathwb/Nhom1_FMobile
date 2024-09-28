package com.group1.fmobile.service.account;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * Dịch vụ gửi email.
 * @author [Ha Van Dat]
 */
@Service
public class MailService {

    // Logger để ghi lại thông tin log
    private static final Logger logger = LoggerFactory.getLogger(MailService.class);

    // Đối tượng JavaMailSender để gửi email
    private final JavaMailSender mailSender;

    @Autowired
    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * Gửi email xác thực tài khoản chứa mã OTP.
     *
     * @param to  Địa chỉ email người nhận.
     * @param otp Mã OTP để xác thực.
     */
    public void sendVerificationEmail(String to, String otp) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject("Xác thực tài khoản");
            message.setText("Mã OTP để xác thực tài khoản của bạn là: " + otp + "\nMã có hiệu lực trong vòng 5 phút.");
            mailSender.send(message);
        } catch (Exception e) {
            logger.error("Lỗi khi gửi email xác thực: ", e);
            throw new RuntimeException("Không thể gửi email xác thực", e);
        }
    }

    /**
     * Gửi email đặt lại mật khẩu chứa mã OTP.
     *
     * @param to  Địa chỉ email người nhận.
     * @param otp Mã OTP để đặt lại mật khẩu.
     */
    public void sendPasswordResetEmail(String to, String otp) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject("Đặt lại mật khẩu");
            message.setText("Mã OTP để đặt lại mật khẩu của bạn là: " + otp);
            mailSender.send(message);
        } catch (Exception e) {
            logger.error("Lỗi khi gửi email đặt lại mật khẩu: ", e);
            throw new RuntimeException("Không thể gửi email đặt lại mật khẩu", e);
        }
    }
    @Async
    public void sendMail(String to, String subject, String content) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(content);
            mailSender.send(message);
        } catch (Exception e) {
            logger.error("Lỗi khi gửi email: ", e);
            throw new RuntimeException("Không thể gửi email ", e);
        }
    }
}
