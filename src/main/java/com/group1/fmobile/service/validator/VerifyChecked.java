package com.group1.fmobile.service.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = VerifyValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface VerifyChecked {
    String message() default "Invalid OTP";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}