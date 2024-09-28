package com.group1.fmobile.service;

import com.group1.fmobile.domain.Product;
import com.group1.fmobile.repository.ProductRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    //Lấy sản phẩm từ database dựa trên id
    public Product getProductById (Long productId){
        return productRepository.findById(productId).orElse(null);
    }

    //Lấy tất cả các sản phẩm từ database
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // Lấy 4 sản phẩm điện thoại mới nhất (product_category_id = 1: smartPhone)
    public List<Product> getTop4SmartPhones() {
        return productRepository.findTop4ByProductCategoryIdOrderByCreatedAtDesc(1L);
    }

    // Lấy 4 sản phẩm bán chạy nhất
    public List<Product> getTop4BestSellingProducts() {
        return productRepository.findTop8ByProductCategoryIdOrderBySoldDesc(1L);
    }

    public List<Product> getTabletProducts(int limit){
        Pageable pageable = PageRequest.of(0, limit);
        return productRepository.findAllTabletByOrderByPriceDesc(pageable);
    }

    @PersistenceContext
    private EntityManager entityManager;

    //    public List<Product> search(String name) {
//        String jpql = "FROM Product p WHERE p.productName LIKE :proName OR p.color LIKE :like OR p.ram LIKE :ram";
//        TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);
//        query.setParameter("proName", "%" + name + "%");
//        query.setParameter("like", "%" + name + "%");
//        query.setParameter("ram", "%" + name + "%");
//        List<Product> products = query.getResultList();
//        return products;
//    }
    public Page<Product> search(String name, int pageNumber, int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize);
        return productRepository.searchProducts(name, pageable);
    }
    // Phân trang
    public long countSearchResults(String name) {
        return productRepository.countSearchResults(name);
    }

    // Lọc
    public Page<Product> filterProducts(int page, int pageSize, List<String> brands, Double minPrice, Double maxPrice, List<String> rams, String color, String searchQuery) {
        PageRequest pageable = PageRequest.of(page - 1, pageSize);
        return productRepository.filterProducts(brands, minPrice, maxPrice, rams, color, searchQuery, pageable);
    }
}

//Tạo ProductService để lấy sản phẩm từ database