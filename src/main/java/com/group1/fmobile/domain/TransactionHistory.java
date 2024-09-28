package com.group1.fmobile.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "TRANSACTION_HISTORY")
public class TransactionHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaction_id", nullable = false)
    Long id;

    //LK Orders
    @OneToOne
    @JoinColumn(name = "order_id", referencedColumnName = "order_id")
    Orders orders;

    //LK Payment Method
    @ManyToOne
    @JoinColumn(name = "payment_method_id", referencedColumnName = "payment_method_id")
    PaymentMethod paymentMethod;

    @Column(name = "transaction_date")
    LocalDateTime transactionDate;

    @Column(name = "status")
    String status;

}