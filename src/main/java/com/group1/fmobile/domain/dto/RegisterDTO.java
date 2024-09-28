package com.group1.fmobile.domain.dto;

import com.group1.fmobile.service.validator.RegisterChecked;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@RegisterChecked
public class RegisterDTO {

    @NotBlank(message = "Email là bắt buộc")
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    String email;

    @NotBlank(message = "Họ tên là bắt buộc")
    @Size(min = 3, message = "Họ tên phải chứa ít nhất 3 ký tự")
    String fullName;

    @NotBlank(message = "Số điện thoại là bắt buộc")
    @Pattern(regexp = "^(0[0-9]{9})$", message = "Số điện thoại không hợp lệ")
    String phone;

    @NotBlank(message = "Địa chỉ là bắt buộc")
    String address;

    @NotBlank(message = "Mật khẩu là bắt buộc")
    @Size(min = 6, message = "Mật khẩu phải chứa ít nhất 6 ký tự")
    String password;


    @NotBlank(message = "Password confirmation is required")

    String confirmPassword;


    public boolean isPasswordMatching() {
        return this.password.equals(this.confirmPassword);
    }
}
