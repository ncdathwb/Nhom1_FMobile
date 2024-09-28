package com.group1.fmobile.domain.dto;

import jakarta.validation.constraints.*;

public class OrderDTO {

    @NotBlank(message = "Full name cannot be empty")
    private String fullName;

    @NotBlank(message = "Address cannot be empty")
    private String address;

    @NotBlank(message = "Phone number cannot be empty")
    @Pattern(regexp = "^0\\d{9,10}$", message = "Phone number must start with 0 and have 10-11 digits")
    private String phone;

    @NotNull(message = "Payment method cannot be empty")
    private Long paymentId;


    @Email(message = "Email should be valid")
//    @NotNull(message = "Email is required")
    private String email;


    // Getters and setters
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Long getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}