package com.group1.fmobile.service.validator;

import com.group1.fmobile.domain.dto.VerifyDTO;
import com.group1.fmobile.service.account.OtpService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Trình xác thực để kiểm tra OTP trong quá trình đăng ký người dùng hoặc đặt lại mật khẩu.
 *
 * @author [Ha Van Dat]
 */
@Service
public class VerifyValidator implements ConstraintValidator<VerifyChecked, VerifyDTO> {
    private final OtpService otpService;

    @Autowired
    public VerifyValidator(OtpService otpService) {
        this.otpService = otpService;
    }

    /**
     * Xác thực mã OTP do người dùng cung cấp so với mã OTP đã lưu trữ liên kết với email của họ.
     *
     * @param verifyDTO DTO chứa mã OTP cần xác thực.
     * @param context ngữ cảnh của trình xác thực ràng buộc.
     * @return true nếu mã OTP hợp lệ, false nếu không.
     */
    @Override
    public boolean isValid(VerifyDTO verifyDTO, ConstraintValidatorContext context) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(true);
        String email = (String) session.getAttribute("registeredEmail");

        // Xác thực mã OTP
        if (!otpService.verifyOtp(email, verifyDTO.getOtp())) {
            context.buildConstraintViolationWithTemplate("OTP code is incorrect or expired.")
                    .addPropertyNode("otp")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            return false;
        }

        return true;
    }
}
