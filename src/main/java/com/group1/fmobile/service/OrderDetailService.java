package com.group1.fmobile.service;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.OrdersDetail;
import com.group1.fmobile.repository.OrdersDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderDetailService {
    private final OrdersDetailRepository ordersDetailRepository;
    @Autowired
    public OrderDetailService(OrdersDetailRepository ordersDetailRepository) {
        this.ordersDetailRepository = ordersDetailRepository;
    }

    public List<OrdersDetail> getAllOrderDetail(Orders orders) {
        return ordersDetailRepository.findByOrders(orders);
    }


}
