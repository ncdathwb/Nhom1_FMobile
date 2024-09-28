package com.group1.fmobile.service.validator;

import com.group1.fmobile.domain.dto.ForgotPasswordDTO;
import com.group1.fmobile.service.UserService;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Trình xác thực để kiểm tra tính hợp lệ của yêu cầu quên mật khẩu.
 * @author [Ha Van Dat]
 */
@Service
public class ForgotValidator implements ConstraintValidator<ForgotChecked, ForgotPasswordDTO> {
    private final UserService userService;

    @Autowired
    public ForgotValidator(UserService userService) {
        this.userService = userService;
    }

    /**
     * Kiểm tra tính hợp lệ của dữ liệu yêu cầu quên mật khẩu.
     *
     * @param user             DTO chứa thông tin yêu cầu quên mật khẩu.
     * @param context          Ngữ cảnh của trình xác thực ràng buộc.
     * @return true nếu dữ liệu hợp lệ, false nếu không.
     */
    @Override
    public boolean isValid(ForgotPasswordDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Kiểm tra xem email có tồn tại hay không
        if (!this.userService.checkEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email does not exist!")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        return valid;
    }
}
