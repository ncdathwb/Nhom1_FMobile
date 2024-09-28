package com.group1.fmobile.service.validator;

import com.group1.fmobile.domain.dto.RegisterDTO;
import com.group1.fmobile.service.UserService;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Trình xác thực để kiểm tra tính hợp lệ của thông tin đăng ký người dùng.
 *  @author [Ha Van Dat]
 */
@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {
    private final UserService userService;

    @Autowired
    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    /**
     * Kiểm tra tính hợp lệ của dữ liệu đăng ký.
     *
     * @param user             DTO chứa thông tin đăng ký.
     * @param context          Ngữ cảnh của trình xác thực ràng buộc.
     * @return true nếu dữ liệu hợp lệ, false nếu không.
     */
    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Kiểm tra xem mật khẩu và xác nhận mật khẩu có khớp nhau hay không
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Password entered is incorrect.")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        // Kiểm tra xem email đã tồn tại hay chưa
        if (this.userService.checkEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email already exists.")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        return valid;
    }
}
