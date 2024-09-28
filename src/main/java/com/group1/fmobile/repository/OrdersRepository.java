package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Orders;
import com.group1.fmobile.domain.User;
import com.group1.fmobile.domain.dto.DailyRevenueDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrdersRepository extends JpaRepository<Orders, Long> {
    List<Orders> findByUser(User user);

    // Tìm tất cả các đơn hàng theo fullname của người dùng
    List<Orders> findAllByUser_Email(String email);

    List<Orders> findAllByUser(User user);

    // Tìm kiếm theo trạng thái với phân trang
    @Query("SELECT o FROM Orders o WHERE o.status LIKE %:search%")
    Page<Orders> searchOrder(@Param("search") String search, Pageable pageable);

    @Override
    Page<Orders> findAll(Pageable pageable);

    // Đếm tổng số lượng đơn hàng của cả hệ thông
    @Query("SELECT COUNT(o) FROM Orders o")
    Long countTotalOrder();

    // Đếm tổng doanh thu
    @Query("SELECT SUM(o.totalPayment) FROM Orders o")
    Double countTotalRevenue();

    // OrdersRepository.java
    @Query("SELECT new com.group1.fmobile.domain.dto.DailyRevenueDTO(o.orderDate, SUM(o.totalPayment)) " +
            "FROM Orders o " +
            "WHERE o.orderDate BETWEEN :startDate AND :endDate " +
            "GROUP BY o.orderDate " +
            "ORDER BY o.orderDate")
    List<DailyRevenueDTO> findRevenueInRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

}
