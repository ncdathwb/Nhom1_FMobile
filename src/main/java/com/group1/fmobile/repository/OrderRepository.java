package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Orders, Long> {

    @Query("select o from Orders o where o.user.id = ?1")
    public Page<Orders> findByUserId(Long userId, Pageable pageable);

    Page<Orders> findByUserIdAndStatus(Long userId, String status, Pageable pageable);

    List<Orders> findByUser(User user);


}
