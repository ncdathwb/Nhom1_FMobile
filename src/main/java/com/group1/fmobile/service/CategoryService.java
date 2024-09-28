package com.group1.fmobile.service;

import com.group1.fmobile.domain.ProductCategory;

import java.util.List;

public interface CategoryService {
    List<ProductCategory> getAll();
    ProductCategory getById(long Id);

    void saveOrUpdate(ProductCategory category);
    void delete(long Id);
}
