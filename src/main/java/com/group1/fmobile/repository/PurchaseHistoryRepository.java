package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PurchaseHistoryRepository extends JpaRepository<Orders, Long> {

    @Query("SELECT o FROM Orders o LEFT JOIN FETCH o.ordersDetails WHERE o.user = :user")
    List<Orders> findByUserWithDetails(@Param("user") User user);

    // Thêm phương thức này
    @Query("SELECT u FROM User u WHERE u.email = :email")
    Optional<User> findByUserByEmail(@Param("email") String email);


}
