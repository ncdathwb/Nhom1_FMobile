package com.group1.fmobile.service;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.repository.OrderInformationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class OrderInformationService {
    private final OrderInformationRepository orderInformationRepository;
    @Autowired
    public OrderInformationService(OrderInformationRepository orderInformationRepository) {
        this.orderInformationRepository = orderInformationRepository;
    }

    public List<Orders> getOrdersByUser(User user) {
        return orderInformationRepository.findByUserWithDetails(user);
    }

    public Optional<User> getUserByEmail(String email) {
        return orderInformationRepository.findUserByEmail(email);
    }

    @Transactional(readOnly = true)
    public Optional<Orders> getOrderById(Long orderId) {
        return orderInformationRepository.findByIdWithAllDetails(orderId);
    }

}
