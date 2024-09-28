package com.group1.fmobile.domain.dto;

import lombok.Data;

@Data
public class OrderDetailDTO {
    private String productName;
    private Integer quantity;
    private double price;
    private String description;
}
