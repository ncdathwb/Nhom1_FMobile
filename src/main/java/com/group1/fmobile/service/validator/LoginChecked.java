package com.group1.fmobile.service.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;


@Constraint(validatedBy = LoginValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LoginChecked {
    String message() default "Invalid login credentials";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
