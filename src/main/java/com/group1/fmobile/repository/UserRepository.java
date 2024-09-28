package com.group1.fmobile.repository;


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
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User save(User user);
    boolean existsByEmail(String email);

    Optional<User> findByFullName(String fullName);

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
    User getById(Long id);
    // Tìm kiếm người dùng theo tên đầy đủ
    @Query("SELECT u FROM User u WHERE u.fullName LIKE %:search%")
    Page<User> searchUsersByFullName(String search, Pageable pageable);
    @Query("SELECT u, COALESCE(SUM(o.totalPayment), 0) FROM User u LEFT JOIN Orders o ON u.id = o.user.id GROUP BY u.id, " +
            "u.address, u.amount, u.creationDate, u.email, u.enabled, u.fullName, u.password, u.phone, u.updatedAt")
    List<Object[]> findTotalPaymentsByUser();
    // Tính tổng tiền theo người dùng với điều kiện tìm kiếm theo tên đầy đủ
    @Query("SELECT u, COALESCE(SUM(o.totalPayment), 0) FROM User u LEFT JOIN Orders o ON u.id = o.user.id " +
            "WHERE u.fullName LIKE %:search% GROUP BY u.id, u.address, u.amount, u.creationDate, u.email, u.enabled, " +
            "u.fullName, u.password, u.phone, u.updatedAt")
    List<Object[]> findTotalPaymentsByUserWithSearch(String search);
    Page<User> findAll(Pageable pageable);
    // Đếm tổng số lượng user của hệ thống
    @Query("SELECT COUNT(u) FROM User u")
    Long countTotalUsers();
}
