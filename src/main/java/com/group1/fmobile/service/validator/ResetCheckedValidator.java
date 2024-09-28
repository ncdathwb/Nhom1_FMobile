package com.group1.fmobile.service.validator;

import com.group1.fmobile.domain.dto.ResetPasswordDTO;
import com.group1.fmobile.service.account.OtpService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Trình xác thực để kiểm tra tính hợp lệ của yêu cầu đặt lại mật khẩu.
 * @author [Ha Van Dat]
 */
@Service
public class ResetCheckedValidator implements ConstraintValidator<ResetPasswordChecked, ResetPasswordDTO> {
    private final OtpService otpService;

    @Autowired
    public ResetCheckedValidator(OtpService otpService) {
        this.otpService = otpService;
    }

    /**
     * Kiểm tra tính hợp lệ của dữ liệu đặt lại mật khẩu.
     *
     * @param user             DTO chứa thông tin đặt lại mật khẩu.
     * @param context          Ngữ cảnh của trình xác thực ràng buộc.
     * @return true nếu dữ liệu hợp lệ, false nếu không.
     */
    @Override
    public boolean isValid(ResetPasswordDTO user, ConstraintValidatorContext context) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(false); // Lấy phiên làm việc hiện tại, không tạo mới nếu chưa có

        // Kiểm tra xem có phiên làm việc hay không
        if (session == null) {
            context.buildConstraintViolationWithTemplate("Invalid session.")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        String email = (String) session.getAttribute("resetEmail"); // Lấy email từ phiên làm việc

        // Kiểm tra xem email có tồn tại trong phiên làm việc hay không
        if (email == null) {
            context.buildConstraintViolationWithTemplate("Email does not exist in the session.")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        // Xác thực mã OTP
        if (!otpService.verifyOtp(email, user.getOtp())) {
            context.buildConstraintViolationWithTemplate("OTP code is incorrect or expired.")
                    .addPropertyNode("otp")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        // Kiểm tra xem mật khẩu mới và xác nhận mật khẩu mới có khớp nhau hay không
        if (!user.getNewPassword().equals(user.getConfirmNewPassword())) {
            context.buildConstraintViolationWithTemplate("Passwords do not match.")
                    .addPropertyNode("confirmNewPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        return true;
    }
}
