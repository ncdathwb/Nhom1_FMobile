package com.group1.fmobile.service.account;

import com.group1.fmobile.domain.User;
import com.group1.fmobile.domain.Role;
import com.group1.fmobile.domain.RoleType;
import com.group1.fmobile.domain.dto.RegisterDTO;
import com.group1.fmobile.service.RoleService;
import com.group1.fmobile.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Dịch vụ quản lý tài khoản người dùng, bao gồm đăng ký, xác thực, đặt lại mật khẩu và đăng nhập.
 */
@Service
@EnableAsync
public class AccountService {
    private static final Logger logger = LoggerFactory.getLogger(AccountService.class);

    private final UserService userService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;
    private final MailService mailService;
    private final OtpService otpService;

    @Autowired
    public AccountService(UserService userService, RoleService roleService, PasswordEncoder passwordEncoder, MailService mailService, OtpService otpService) {
        this.userService = userService;
        this.roleService = roleService;
        this.passwordEncoder = passwordEncoder;
        this.mailService = mailService;
        this.otpService = otpService;
    }

    /**
     * Đăng ký người dùng mới.
     */
    @Transactional
    @Async
    public void registerUser(RegisterDTO registerDTO) {
        try {
            User user = new User();
            user.setEmail(registerDTO.getEmail());
            user.setFullName(registerDTO.getFullName());
            user.setPhone(registerDTO.getPhone());
            user.setAddress(registerDTO.getAddress());
            user.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
            user.setEnabled(false);
            user.setCreationDate(LocalDate.now());
            user.setUpdatedAt(LocalDateTime.now());

            Role userRole = roleService.findByName(RoleType.USER
                    )
                    .orElseGet(() -> {
                        Role newRole = new Role();
                        newRole.setName(RoleType.USER);
                        return roleService.save(newRole);
                    });

            Set<Role> roles = new HashSet<>();
            roles.add(userRole);
            user.setRoles(roles);

            userService.saveAccount(user);

            String otp = otpService.generateOTP();
            otpService.saveOtp(user.getEmail(), otp);
            mailService.sendVerificationEmail(user.getEmail(), otp);

        } catch (Exception e) {
            logger.error("Lỗi khi đăng ký người dùng", e);
            throw new RuntimeException("Không thể đăng ký người dùng", e);
        }
    }

    /**
     * Xác thực tài khoản người dùng bằng mã OTP.
     */
    @Transactional
    public boolean verifyAccount(String email, String otp) {
        try {
            if (otpService.verifyOtp(email, otp)) {
                User user = userService.findByEmail(email);
                user.setEnabled(true);
                userService.saveAccount(user);
                otpService.removeOtp(email);
                return true;
            }
        } catch (Exception e) {
            logger.error("Lỗi khi xác thực tài khoản: ", e);
        }
        return false;
    }

    /**
     * Gửi lại mã OTP xác thực cho người dùng.
     */
    public void resendOTP(String email) {
        try {
            User user = userService.findByEmail(email);
            if (!user.isEnabled()) {
                String otp = otpService.generateOTP();
                otpService.saveOtp(email, otp);
                mailService.sendVerificationEmail(email, otp);
            } else {
                throw new RuntimeException("Tài khoản đã được xác thực");
            }
        } catch (Exception e) {
            logger.error("Lỗi khi gửi lại OTP xác thực: ", e);
            throw new RuntimeException("Không thể gửi lại OTP xác thực", e);
        }
    }

    /**
     * Khởi tạo quá trình đặt lại mật khẩu bằng cách gửi mã OTP đến email của người dùng.
     */
    @Async
    public void initiatePasswordReset(String email) {
        try {
            User user = userService.findByEmail(email);
            if (user != null) {
                String otp = otpService.generateOTP();
                otpService.saveOtp(email, otp);
                mailService.sendPasswordResetEmail(email, otp);
            }
        } catch (Exception e) {
            logger.error("Lỗi khi khởi tạo đặt lại mật khẩu: ", e);
            throw new RuntimeException("Không thể khởi tạo đặt lại mật khẩu", e);
        }
    }

    /**
     * Đặt lại mật khẩu cho người dùng.
     */
    public boolean resetPassword(String email, String otp, String newPassword) {
        try {
            if (otpService.verifyOtp(email, otp)) {
                User user = userService.findByEmail(email);
                if (user != null) {
                    user.setPassword(passwordEncoder.encode(newPassword));
                    userService.saveAccount(user);
                    otpService.removeOtp(email);
                    return true;
                }
            }
        } catch (Exception e) {
            logger.error("Lỗi khi đặt lại mật khẩu: ", e);
        }
        return false;
    }

    /**
     * Xác thực người dùng bằng tên đăng nhập và mật khẩu.
     */
    public boolean authenticateUser(String username, String password) {
        User user = userService.findByEmail(username);
        if (user != null && user.isEnabled()) {
            return passwordEncoder.matches(password, user.getPassword());
        }
        return false;
    }
}
