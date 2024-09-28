package com.group1.fmobile.service.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Constraint(validatedBy = ForgotValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ForgotChecked {
    String message() default "Invalid forgot password failed";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
