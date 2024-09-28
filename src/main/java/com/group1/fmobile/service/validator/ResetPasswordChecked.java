package com.group1.fmobile.service.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Constraint(validatedBy = ResetCheckedValidator.class)
@Target({ElementType.TYPE})
@Documented
@Retention(RetentionPolicy.RUNTIME)
public @interface ResetPasswordChecked {
    String message() default "Invalid Password fail";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
