package com.group1.fmobile.service.validator;

import com.group1.fmobile.domain.dto.LoginDTO;
import com.group1.fmobile.service.UserService;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginValidator implements ConstraintValidator<LoginChecked, LoginDTO> {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public LoginValidator(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public boolean isValid(LoginDTO loginDTO, ConstraintValidatorContext context) {
        boolean valid = true;
        if (!this.userService.checkEmailExist(loginDTO.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email không tồn tại")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }else {

            String encodedPassword = this.userService.getPasswordByEmail(loginDTO.getEmail());


            if (!this.passwordEncoder.matches(loginDTO.getPassword(), encodedPassword)) {
                context.buildConstraintViolationWithTemplate("Mật khẩu không đúng")
                        .addPropertyNode("password")
                        .addConstraintViolation()
                        .disableDefaultConstraintViolation();
                valid = false;
            }
        }



        return valid;
    }
}
