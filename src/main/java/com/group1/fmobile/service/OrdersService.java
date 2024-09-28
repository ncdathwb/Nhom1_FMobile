package com.group1.fmobile.service;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.domain.dto.DailyRevenueDTO;
import com.group1.fmobile.repository.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrdersService {
    private final OrdersRepository ordersRepository;

    @Autowired
    public OrdersService(OrdersRepository ordersRepository) {
        this.ordersRepository = ordersRepository;
    }

        // Hàm lấy danh sách Orders theo email của người dùng
    public List<Orders> findOrdersByUser(User user) {
        return ordersRepository.findByUser(user);
    }
    
    public List<Orders> getAllOrder() {
        return this.ordersRepository.findAll();
    }


    public Page<Orders> findOrdersByStatus(String search, Pageable pageable) {
        if (search == null || search.isEmpty()) {
            return ordersRepository.findAll(pageable);
        } else {
            return ordersRepository.searchOrder(search, pageable);
        }
    }

    public Long countTotalOrder() {
        return this.ordersRepository.countTotalOrder();
    }

    public Double countTotalRevenue() {
        return this.ordersRepository.countTotalRevenue();
    }

    public List<DailyRevenueDTO> getRevenueInRange(LocalDateTime startDate, LocalDateTime endDate) {
        return ordersRepository.findRevenueInRange(startDate, endDate);
    }
}
