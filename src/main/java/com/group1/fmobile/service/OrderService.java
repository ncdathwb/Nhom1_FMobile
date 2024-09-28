package com.group1.fmobile.service;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.OrdersDetail;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.repository.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    private final OrdersRepository ordersRepository;
    @Autowired
    public OrderService(OrdersRepository ordersRepository) {
        this.ordersRepository = ordersRepository;
    }

    // Hàm lấy danh sách Orders theo email của người dùng
    public List<Orders> findOrdersByUser(User user) {
        return ordersRepository.findByUser(user);
    }
}