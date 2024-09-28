package com.group1.fmobile.service;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.OrdersDetail;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.domain.UserNotFoundException;
import com.group1.fmobile.domain.dto.OrderDTO;
import com.group1.fmobile.domain.dto.OrderDetailDTO;
import com.group1.fmobile.domain.dto.OrderHistoryDTO;
import com.group1.fmobile.repository.OrdersDetailRepository;
import com.group1.fmobile.repository.PurchaseHistoryRepository;
import com.group1.fmobile.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class PurchaseHistoryService {
    private final UserRepository userRepository;
    private final PurchaseHistoryRepository purchaseHistoryRepository;
    private final OrdersDetailRepository ordersDetailRepository;

    @Autowired
    public PurchaseHistoryService(UserRepository userRepository,
                                  PurchaseHistoryRepository purchaseHistoryRepository,
                                  OrdersDetailRepository ordersDetailRepository) {
        this.userRepository = userRepository;
        this.purchaseHistoryRepository = purchaseHistoryRepository;
        this.ordersDetailRepository = ordersDetailRepository;
    }

    public List<OrderHistoryDTO> getPurchaseHistory(String email) {
        log.info("Fetching purchase history for user with email: {}", email);

        User user = purchaseHistoryRepository.findByUserByEmail(email)
                .orElseThrow(() -> {
                    log.error("User not found with email: {}", email);
                    return new UserNotFoundException("User not found with email: " + email);
                });

        List<Orders> orders = purchaseHistoryRepository.findByUserWithDetails(user);

        if (orders.isEmpty()) {
            log.info("No orders found for user: {}", email);
            return Collections.emptyList();
        }

        log.info("Found {} orders for user", orders.size());
        return orders.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private OrderHistoryDTO convertToDTO(Orders order) {
        OrderHistoryDTO dto = new OrderHistoryDTO();
        dto.setId(order.getId());
        dto.setOrderDate(order.getOrderDate());
        dto.setTotalPayment(order.getTotalPayment());
        dto.setStatus(order.getStatus());

        List<OrdersDetail> details = ordersDetailRepository.findByOrders(order);
        List<OrderDetailDTO> detailDTOs = details.stream()
                .map(this::convertToDetailDTO)
                .collect(Collectors.toList());
        dto.setOrderDetails(detailDTOs);

        return dto;
    }

    private OrderDetailDTO convertToDetailDTO(OrdersDetail detail) {
        OrderDetailDTO dto = new OrderDetailDTO();
        dto.setProductName(detail.getProduct().getProductName());
        dto.setQuantity(detail.getQuantity());
        dto.setPrice(detail.getPrice());
        return dto;
    }

    @Transactional
    public boolean deleteOrder(Long orderId, String userEmail) {
        Optional<User> userOpt = purchaseHistoryRepository.findByUserByEmail(userEmail);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            Optional<Orders> orderOpt = purchaseHistoryRepository.findById(orderId);
            if (orderOpt.isPresent() && orderOpt.get().getUser().equals(user)) {
                Orders order = orderOpt.get();
                ordersDetailRepository.deleteAll(order.getOrdersDetails());
                purchaseHistoryRepository.delete(order);
                return true;
            }
        }
        return false;
    }


}
