package com.group1.fmobile.repository;

import com.group1.fmobile.domain.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface BrandRepository extends JpaRepository<Brand, Long> {
    Brand findByBrandName(String brandName);
    // Phương thức kiểm tra tính duy nhất của tên thương hiệu

}
