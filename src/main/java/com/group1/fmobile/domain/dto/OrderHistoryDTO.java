package com.group1.fmobile.domain.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderHistoryDTO {
    private Long id;
    private LocalDateTime orderDate;
    private double totalPayment;
    private String status;
    private List<OrderDetailDTO> orderDetails;
}
