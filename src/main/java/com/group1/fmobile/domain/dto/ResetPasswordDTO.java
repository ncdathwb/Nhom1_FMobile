package com.group1.fmobile.domain.dto;

import com.group1.fmobile.service.validator.ResetPasswordChecked;

import jakarta.validation.constraints.NotNull;

import jakarta.validation.constraints.Size;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;


import java.util.Objects;


@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@ResetPasswordChecked
public class ResetPasswordDTO {

    String otp;

    @Size(min = 6, message = "Password must contain at least 6 characters")

    String newPassword;
    String confirmNewPassword;


}
