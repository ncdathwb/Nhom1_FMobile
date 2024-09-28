package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.OrdersDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrdersDetailRepository extends JpaRepository<OrdersDetail, Long> {
    List<OrdersDetail> findByOrders(Orders orders);

}
