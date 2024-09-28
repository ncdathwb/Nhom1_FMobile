package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Discount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DiscountRepository extends JpaRepository<Discount, Long> {

    @Query("select d from Discount d where d.minPurchaseAmount <= ?1 order by d.discountValue desc ")
    public List<Discount> findByAmount(Double amount);
}
