package com.group1.fmobile.domain.dto;

import com.group1.fmobile.service.validator.VerifyChecked;
import lombok.AccessLevel;


import lombok.Data;

import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@VerifyChecked
public class VerifyDTO {
    String otp;
}
