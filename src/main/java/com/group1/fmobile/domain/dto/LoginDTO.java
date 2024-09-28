package com.group1.fmobile.domain.dto;

import com.group1.fmobile.service.validator.LoginChecked;
import jakarta.validation.constraints.Email;

import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;

import lombok.Data;

import lombok.experimental.FieldDefaults;



@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@LoginChecked
public class LoginDTO  {

    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    String email;
    @NotNull(message = "Mật khẩu không được để trống")
    String password;
}
