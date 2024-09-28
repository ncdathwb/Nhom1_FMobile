package com.group1.fmobile.service;

import com.group1.fmobile.domain.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface IProductService {
    List<Product> getAll();
    Product getById(long Id);
    void saveOrUpdate(Product product);
    void delete(long Id);
    Page<Product> getAll(Integer pageNo);
    List<Product> searchProducts(String keyword);
    Page<Product> searchAndPaginationProduct(String keyword, Integer pageNo);
}
