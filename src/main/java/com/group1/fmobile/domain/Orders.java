package com.group1.fmobile.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;


@Entity
@Table(name = "ORDERS")
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id", nullable = false)
    Long id;

    //LK User
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    User user;

    //LK Discount
    @ManyToOne
    @JoinColumn(name = "discount_id")
    Discount discount;

    String phone;

    String fullName;

    String email;

    @Column(name = "total_payment", nullable = false)
    double totalPayment;

    @Column(name = "status", length = 50)
    String status;

    @Column(name = "order_date")
    LocalDateTime orderDate;

    @Column(name = "shipping_address")
    String shippingAddress;

    //LK Orders Detail
    @OneToMany(mappedBy = "orders", fetch = FetchType.EAGER)
    List<OrdersDetail> ordersDetails;

    // LK Transaction History
    @OneToOne(mappedBy = "orders")
    TransactionHistory transactionHistory;

    @ManyToOne
    @JoinColumn(name = "payment_method_id")
    private PaymentMethod paymentMethod;

    // Helper methods for managing bidirectional relationships
    public void addOrderDetail(OrdersDetail orderDetail) {
        ordersDetails.add(orderDetail);
        orderDetail.setOrders(this);
    }

    public void removeOrderDetail(OrdersDetail orderDetail) {
        ordersDetails.remove(orderDetail);
        orderDetail.setOrders(null);
    }

    public void setTransactionHistory(TransactionHistory transactionHistory) {
        if (transactionHistory == null) {
            if (this.transactionHistory != null) {
                this.transactionHistory.setOrders(null);
            }
        } else {
            transactionHistory.setOrders(this);
        }
        this.transactionHistory = transactionHistory;
    }

}