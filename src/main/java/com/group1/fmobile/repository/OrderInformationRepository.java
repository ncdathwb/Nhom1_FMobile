package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderInformationRepository extends JpaRepository<Orders, Long> {
    @Query("SELECT o FROM Orders o LEFT JOIN FETCH o.ordersDetails WHERE o.user = :user")
    List<Orders> findByUserWithDetails(@Param("user") User user);

    @Query("SELECT u FROM User u WHERE u.email = :email")
    Optional<User> findUserByEmail(@Param("email") String email);

    @Query("SELECT o FROM Orders o " +
            "LEFT JOIN FETCH o.ordersDetails od " +
            "LEFT JOIN FETCH od.product " +
            "LEFT JOIN FETCH o.user " +
            "LEFT JOIN FETCH o.discount " +
            "LEFT JOIN FETCH o.transactionHistory " +
            "WHERE o.id = :orderId")
    Optional<Orders> findByIdWithAllDetails(@Param("orderId") Long orderId);
}
