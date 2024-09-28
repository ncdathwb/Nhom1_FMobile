package com.group1.fmobile.repository;

import com.group1.fmobile.domain.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Locale;

public interface CategoryRepository extends JpaRepository<ProductCategory, Long> {
    ProductCategory findByCategoryName(String CategoryName);

}
